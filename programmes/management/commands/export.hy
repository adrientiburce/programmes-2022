(require hyrule [-> doto])

(import
  pathlib [Path]
  shutil [copytree rmtree])

(import
  bs4 [BeautifulSoup]
  django.core.management.base [BaseCommand CommandError]
  django.test [Client]
  django.urls [reverse]
  sass)

(import programmes.models [Manifesto])


(defclass Command [BaseCommand]
  (setv
    help "Export the website"
    client (Client))

  (defn handle [self #* args #** options]
    (doto self
      (.setup-folder)
      (.content-at (reverse "home"))
      (.contents-of Manifesto "manifesto-list" "manifesto-detail")
      (.content-at (reverse "candidate-list"))
      (.copy-assets))
    "Done! Result build is in 'site' folder.")
  
  (defn content-at [self url]
    (.mkdir (Path f"site{url}") :exist_ok True :parents True)
    (with [f (open f"site{url}index.html" "w")]
      (self.stdout.write f"Writing site{url}index.html")
      (f.write
        (-> self.client
          (.get url)
          (. content)
          (.decode)
          (BeautifulSoup :features "html.parser")
          (.prettify)))))
  
  (defn contents-of [self model-cls list-name detail-name]
    (self.content-at (reverse list-name))
    (for [obj (model-cls.objects.iterator)]
      (self.content-at (reverse detail-name :args [obj.slug]))))
  
  (defn setup-folder [self]
    (setv site-path (Path "site"))
    (if (site-path.is-dir)
      (rmtree "site"))
    (site-path.mkdir))
  
  (defn copy-assets [self]
    (sass.compile :dirname (, "programmes/static" "site/static"))))

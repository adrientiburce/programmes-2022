(import
  [django.urls [reverse]]
  [hyccup.core [html]]
  [hyccup.element [link-to]]
  [hyccup.page [html5 include-css]]
  [programmes.renderers.layouts.page [render-in-page]])
  
(defn render []
  (render-in-page
    ['div {'class "container"}
      ['div {'class "center-block"}
        ['h1 
          ['span {'class "title-word"} "Programmes"]
          ['span {'class "title-year"} "2022"]]
        ['div {'class "abstract"}
          "En mai prochain se déroulera en France l'élection présidentielle de 2022.
           S'il s'agira d'élire la personnalité qui guidera la politique du pays pour
           les cinq prochaines années, ce site va tenter de synthétiser les programmes
           portés par chacun des candidats, afin de vous éclairer dans votre choix."]
        (link-to {'class "link--programmes"} (reverse "manifesto-list") "Consulter les programmes des candidats")
        (link-to {'class "link--candidates"} (reverse "candidate-list") "En savoir plus sur les candidats")]]))

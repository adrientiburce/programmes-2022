# Generated by Django 4.0.1 on 2022-01-10 22:41

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('programmes', '0008_auto_20210920_2102'),
    ]

    operations = [
        migrations.AlterField(
            model_name='manifestoparagraph',
            name='manifesto',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='paragraphs', related_query_name='pragraph', to='programmes.manifesto', verbose_name='programme'),
        ),
        migrations.AlterField(
            model_name='manifestoparagraph',
            name='topic',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='programmes.topic', verbose_name='thème'),
        ),
    ]

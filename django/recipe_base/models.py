import datetime

from django.db import models
from django.utils import timezone
from django.contrib.postgres.fields import ArrayField


class Recipe(models.Model):
    label = models.CharField(max_length=200)
    image = models.DateTimeField("date published")
    ingredients = ArrayField(models.CharField(max_length=200))
    calories = models.FloatField()
    source_link = models.URLField(max_length=200)

    def __str__(self):
        return self.label

from django import forms


class RecipeSearch(forms.Form):
    query = forms.CharField(label="Search", max_length=100)

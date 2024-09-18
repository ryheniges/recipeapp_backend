from ninja import Router
from ..models import Recipe
from .schemas import RecipeSchema
from django.shortcuts import get_object_or_404

router = Router()


@router.get("/")
def list_recipes(request):
    return [recipe for recipe in Recipe.objects.all()]


@router.get("/{id}")
def get_recipes(request):
    return get_object_or_404(Recipe, pk=id)


@router.post("/")
def create_recipe(request, payload: RecipeSchema):
    recipe = Recipe.objects.create(**payload.dict())
    return {"id": recipe.id}

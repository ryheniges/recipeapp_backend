from ninja import Schema
from typing import List


class RecipeSchema(Schema):
    id: int
    label: str
    image: str
    ingredients: List[str]
    calories: float
    source_link: str

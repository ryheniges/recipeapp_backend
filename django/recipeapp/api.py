from ninja import NinjaAPI
from recipe_base.api.routes import router as recipe_base_router

api = NinjaAPI()

api.add_router("/recipes/", recipe_base_router)

module RecipesHelper
  require 'tasks/get_recipe'
  require 'tasks/recipe_dto'

  def self.saved_recipe_from_api(recipe_data)
    recipe_call = GetRecipe.new(recipe_data.edamam_uri)
    recipe = recipe_call.find_recipe[0]
    RecipeDto.new(recipe)
  end
end

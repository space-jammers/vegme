module RecipesHelper
  require 'tasks/get_recipe'
  require 'tasks/recipe_dto'

  def self.recipe_dto_from_api(recipe_data)
    recipe_call = GetRecipe.new(recipe_data.edamam_id)
    recipe = recipe_call.find_recipe[0]
    RecipeDto.new(recipe)
  end
end

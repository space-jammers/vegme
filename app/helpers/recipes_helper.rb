module RecipesHelper
  require 'tasks/get_recipe'
  require 'tasks/recipe_dto'
  require 'tasks/recipe_errors'

  def self.recipe_dto_from_api(recipe_data)
    recipe_call = GetRecipe.new(recipe_data.edamam_id)
    recipe = recipe_call.find_recipe
    RecipeErrors.store_api_result(recipe)
    return if RecipeErrors.recipe_error?
    RecipeDto.new(recipe[0])
  end
end

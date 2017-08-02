module RecipesHelper
  require 'tasks/get_recipe'
  require 'tasks/recipe_dto'
  require 'tasks/recipe_errors'

  def self.recipe_dto_from_api(recipe_data)
    recipe_call = GetRecipe.new(recipe_data.edamam_id)
    recipe = recipe_call.find_recipe
    RecipeErrors.store_api_result(recipe)
    RecipeErrors.api_limit? ? return : RecipeDto.new(recipe[0])
  end

  def self.cals_from_fat(recipe)
    (recipe.fat / recipe.yield) * 9
  end

  def self.cals_from_protein(recipe)
    (recipe.protein / recipe.yield) * 4
  end

  def self.cals_from_carbs(recipe)
    (recipe.carbs / recipe.yield) * 4
  end
end

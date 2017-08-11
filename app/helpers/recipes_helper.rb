module RecipesHelper
  def self.recipe_dto_from_api(recipe_data)
    recipe_call = GetRecipe.new(recipe_data.edamam_id)
    recipe = recipe_call.find_recipe
    RecipeErrors.store_api_result(recipe)
    RecipeErrors.api_limit? ? return : RecipeDto.new(recipe[0])
  end

  def self.percent_cals_from_fat(recipe)
    ((recipe.fat * 9) / recipe.calories) * 100
  end

  def self.percent_cals_from_protein(recipe)
    ((recipe.protein * 4) / recipe.calories) * 100
  end

  def self.percent_cals_from_carbs(recipe)
    ((recipe.carbs * 4) / recipe.calories) * 100
  end
end

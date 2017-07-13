class RecipesController < ApplicationController
  require 'tasks/get_recipe'
  require 'tasks/recipe_dto'

  def show
    my_recipe = Recipe.find(params[:id])
    recipe_call = GetRecipe.new(my_recipe.edamam_uri)
    @recipe = recipe_call.find_recipe[0]
    @recipe_dto = RecipeDto.new(@recipe)
  end
end

class RecipesController < ApplicationController
  require 'tasks/get_recipe'
  def show
    my_recipe = Recipe.find(params[:id])
    recipe_call = GetRecipe.new(my_recipe.edamam_id)
    @recipe = recipe_call.find_recipe
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :edamam_id)
  end
end

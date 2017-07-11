class RecipesController < ApplicationController
  require 'tasks/get_recipe'

  def show
    my_recipe = Recipe.find(params[:id])
    recipe_call = GetRecipe.new(my_recipe.edamam_id)
    @recipe = recipe_call.find_recipe[0]
  end
end

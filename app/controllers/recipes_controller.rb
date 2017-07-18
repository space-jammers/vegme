class RecipesController < ApplicationController
  require 'tasks/help_recipe_show'
  def show
    recipe = Recipe.find_by_id(params[:id])
    if recipe
      @recipe = RecipesHelper.saved_recipe_from_api(recipe)
    else
      # can redirect back to user dashboard once implemented
      redirect_to action: 'show', id: 1, status: :not_found
    end
  end
end

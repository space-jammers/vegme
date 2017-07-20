class RecipesController < ApplicationController
  before_action :authenticate_user!
  def show
    recipe = if params[:name]
               Recipe.new(name: params[:name], edamam_id: params[:id])
             else
               Recipe.find_by_id(params[:id])
             end

    if recipe
      @recipe = RecipesHelper.recipe_dto_from_api(recipe)
    else
      # can redirect back to user dashboard once implemented for favorites,
      # user dashboard for saved recipes
      redirect_to action: 'show', id: 1, status: :not_found
    end
  end
end

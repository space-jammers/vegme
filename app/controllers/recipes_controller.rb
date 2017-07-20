class RecipesController < ApplicationController
  def show
    # recipe = Recipe.find_by_id(params[:id]) || Recipe.new(params[:edamam_uri],
    #  params[:name])
    if params[:name]
      recipe = Recipe.new(params[:edamam_uri], params[:name])
    else
      recipe = Recipe.find_by_id(params[:id])
    end
    if recipe
      @recipe = RecipesHelper.saved_recipe_from_api(recipe)
    else
      # can redirect back to user dashboard once implemented
      redirect_to action: 'show', id: 1, status: :not_found
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :edamam_uri)
  end
end

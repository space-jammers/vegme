class RecipesController < ApplicationController
  require 'tasks/recipe_errors'
  before_action :authenticate_user!, only: %i[create show destroy]

  def index
    recipes = current_user.recipes.all
    render json: recipes
  end

  def show
    recipe = if params[:recipe_name]
               current_user.recipes.new(name: params[:recipe_name],
                                        edamam_id: params[:id],
                                        dislike: params[:dislike])
             else
               current_user.recipes.find_by_id(params[:id])
             end

    if recipe
      @recipe = RecipesHelper.recipe_dto_from_api(recipe)
      redirect_to root_path if RecipeErrors.api_limit?
    else
      # can redirect back to user dashboard once implemented for favorites,
      # user dashboard for saved recipes
      redirect_to dashboard_path, status: :not_found
    end
  end

  def create
    current_user.recipes.create(name: params[:recipe_name],
                                edamam_id: params[:id],
                                dislike: params[:id])
    redirect_to root_path
  end

  def destroy
    @recipe = current_user.recipes.find_by(id: params[:id])
    @recipe.destroy
    redirect_to dashboard_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :edamam_id, :dislike)
  end
end

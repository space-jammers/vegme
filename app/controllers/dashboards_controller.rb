class DashboardsController < ApplicationController
  before_action :authenticate_user!
  def show
    @favs = current_user.recipes.where(dislike: false).order('name')
    @dislikes = current_user.recipes.where(dislike: true).order('name')
  end
end

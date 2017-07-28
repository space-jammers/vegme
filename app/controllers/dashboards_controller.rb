class DashboardsController < ApplicationController
  before_action :authenticate_user!
  def show
    @favs = current_user.recipes.where(dislike: false)
    @dislikes = current_user.recipes.where(dislike: true)
  end
end

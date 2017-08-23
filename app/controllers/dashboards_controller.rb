class DashboardsController < ApplicationController
  before_action :authenticate_user_or_admin!
  def show
    @favs = current_user.recipes.where(dislike: false).order('name')
    @dislikes = current_user.recipes.where(dislike: true).order('name')
    @user = current_user
  end
end

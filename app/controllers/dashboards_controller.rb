class DashboardsController < ApplicationController
  before_action :authenticate_user!
  def show
    @favs = current_user.recipes
  end
end

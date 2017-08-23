class FeedbacksController < ApplicationController
  before_action :authenticate_user!

  def new
    redirect_to new_user_session_path if curren_user = nil
  end

  def create;end
end

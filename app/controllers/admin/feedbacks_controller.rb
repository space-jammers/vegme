class Admin::FeedbacksController < ApplicationController
  before_action :authenticate_admin!
  def index
    @feedbacks = Feedback.all
  end
end

class Admin::FeedbacksController < ApplicationController
  before_action :authenticate_admin!
  def index
    @feedbacks = Feedback.all.order(:created_at)
  end

  def update
    feedback = Feedback.find(params[:id])
    feedback.update_attributes(feedback_params)
  end
end

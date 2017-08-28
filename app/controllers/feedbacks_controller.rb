class FeedbacksController < ApplicationController
  before_action :authenticate_user!

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.create(feedback_params)
    if @feedback.valid?
      FeedbacksMailer.admin_notification(@feedback).deliver
      flash[:success] = 'Thanks for your feedback!'
      redirect_to queries_path
    else
      render :new, status: :unprocessable_entity
    end
  end
end

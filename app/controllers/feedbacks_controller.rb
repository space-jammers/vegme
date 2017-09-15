class FeedbacksController < ApplicationController
  before_action :authenticate_user!
  after_action :save_previous_url, only: [:new]

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.create(feedback_params)
    if @feedback.valid?
      FeedbacksMailer.admin_notification(@feedback).deliver
      flash[:success] = 'Thanks for your feedback!'
      redirect_to session[:previous_url] || queries_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def save_previous_url
    session[:previous_url] = URI(request.referer || '').path
  end
end

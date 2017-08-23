class FeedbacksController < ApplicationController
  before_action :authenticate_user!

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.create(feedback_params)
    redirect_to queries_path
  end

  private

  def feedback_params
    params.require(:feedback).permit(:label,
                                     :message,
                                     :link,
                                     :user_id,
                                     :admin_id,
                                     :complete)
  end
end

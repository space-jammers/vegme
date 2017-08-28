class Admin::FeedbacksController < ApplicationController
  before_action :authenticate_admin!
  def index
    @feedbacks = Feedback.all.order(:created_at)
  end

  def update
    feedback = Feedback.find_by_id(params[:id])
    return render plain: 'Feedback not found', status: :not_found if feedback.blank?
    feedback.update_attributes(feedback_params)
  end
end

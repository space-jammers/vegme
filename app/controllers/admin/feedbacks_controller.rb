class Admin::FeedbacksController < ApplicationController
  def index
    @feedbacks = Feedback.all
  end
end

class FeedbacksMailer < ApplicationMailer
  def admin_notification
    mail(to: 'lindsaykayedutton@gmail.com', subject: 'New Feedback')
  end
end

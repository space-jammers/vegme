class FeedbacksMailer < ApplicationMailer
  helper :application
  def admin_notification(feedback)
    @feedback = feedback
    mail(to: [ENV['hm_email'], ENV['ld_email']], subject: 'New Feedback')
  end
end

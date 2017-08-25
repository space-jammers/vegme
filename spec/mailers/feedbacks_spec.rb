require 'rails_helper'

RSpec.describe FeedbacksMailer, type: :mailer do
  describe 'admin_notification' do
    let!(:admin1) do
      User.create!(email: ENV['hm_email'],
                   password: 'sdkjh59sda',
                   admin: true)
    end

    let!(:feedback) do
      Feedback.create(user_id: admin1.id,
                      label: 'idea',
                      message: 'test',
                      link: 'www.cats.com')
    end

    let(:mail) { FeedbacksMailer.admin_notification(feedback) }

    it 'renders the subject' do
      expect(mail.subject).to eq('New Feedback')
    end

    it 'renders the receiver email' do
      expect(mail.to[0]).to eq(admin1.email)
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['vegme.team@gmail.com'])
    end

    it 'assigns @feedback' do
      expect(mail.body.encoded).to match(feedback.message)
    end
  end
end

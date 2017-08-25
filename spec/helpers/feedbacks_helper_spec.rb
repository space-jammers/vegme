require 'rails_helper'
RSpec.describe FeedbacksHelper, type: :helper do
  let!(:admin1) do
    User.create!(email: ENV['hm_email'],
                 password: 'sdkjh59sda',
                 admin: true)
  end

  let!(:admin2) do
    User.create!(email: ENV['ld_email'],
                 password: 'sdkjh59sda',
                 admin: true)
  end
  describe 'admin_ids' do
    it 'returns an array with admin initials and ids' do
      expect(admin_ids).to match_array([[admin2.id, 'LD'], [admin1.id, 'HM']])
    end
  end
end

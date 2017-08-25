module FeedbacksHelper
  def admin_ids
    l_id = User.find_by(email: ENV['ld_email']).id
    h_id = User.find_by(email: ENV['hm_email']).id
    [[l_id, 'LD'], [h_id, 'HM']]
  end
end

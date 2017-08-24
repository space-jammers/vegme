module FeedbacksHelper
  def admin_ids
    l_id = User.find_by(email: ENV['ld_email']).id
    h_id = User.find_by(email: ENV['hm_email']).id
    ids = [l_id, h_id]
    ids
  end
end

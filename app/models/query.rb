class Query < ApplicationRecord
  before_create :remove_previous_record

  private

  def remove_previous_record
    self.class.first.destroy if self.class.count > 0
  end
end

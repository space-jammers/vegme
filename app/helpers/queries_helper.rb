require 'securerandom'
module QueriesHelper
  def make_dto
    RecipeDto.new(self['recipe'])
  end

  def create_search_id
    SecureRandom.uuid
  end
end

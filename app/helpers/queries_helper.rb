module QueriesHelper
  require 'tasks/recipe_dto'
  require 'securerandom'


  def make_dto
    RecipeDto.new(self['recipe'])
  end

  def create_search_id
    SecureRandom.uuid
  end
end

module QueriesHelper
  require 'tasks/recipe_dto'

  def hits
    self['hits']
  end

  def make_dto
    RecipeDto.new(self['recipe'])
  end
end

# @recipes == HTTParty::Response
# @recipes['hits'] == Array
# @recipes['hits'].each --> recipe['recipe'] == Hash

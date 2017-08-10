module QueriesHelper
  require 'tasks/recipe_dto'


  def make_dto
    RecipeDto.new(self['recipe'])
  end
end

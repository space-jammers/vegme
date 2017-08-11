require 'httparty'
class GetRecipe
  include HTTParty
  base_uri 'https://api.edamam.com'
  format :json

  def initialize(edamam_id)
    @options = {
      query: {
        r: 'http://www.edamam.com/ontologies/edamam.owl#recipe_' + edamam_id.to_s,
        app_id: ENV['app_id'],
        app_key: ENV['app_key']
      }
    }
  end

  def find_recipe
    getter = self.class.get('/search', @options)
    getter.success? ? getter : getter.code
  end
end

require 'httparty'
class RecipeQuery
  include HTTParty
  base_uri 'https://api.edamam.com'
  format :json

  def initialize(q, limit, health)
    @options = {
      query: {
        q: q,
        app_id: ENV['app_id'],
        app_key: ENV['app_key'],
        from: 0,
        to: limit,
        health: health
      }
    }
  end

  def search
    query = self.class.get('/search', @options)
    if query.success?
      query
    else
      query.code
    end
  end
end

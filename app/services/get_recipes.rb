require 'httparty'
include QueriesHelper
class GetRecipes
  include HTTParty
  base_uri 'https://api.edamam.com'
  format :json

  def initialize(q, max_cal, health)
    @options = {
      query: {
        q: q,
        app_id: ENV['app_id'],
        app_key: ENV['app_key'],
        to: 200,
        calories: 'gte 1, lte ' + max_cal,
        health: health
      }
    }
  end

  def search
    query = self.class.get('/search', @options)
    query.success? ? query : query.code
  end
end

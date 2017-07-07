require 'httparty'
class Recipe
  include HTTParty
  base_uri 'https://api.edamam.com'
  format :json

  attr_accessor :storage_for_json_object

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
    self.class.get('/search', @options)
  end

  def self.store_query(json_object)
    @storage_for_json_object = []
    @storage_for_json_object << json_object
  end
  
  def self.return_query
    @storage_for_json_object
  end
end

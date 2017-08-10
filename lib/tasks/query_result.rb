require 'securerandom'
class QueryResult
  attr_accessor :query_result, :query_term, :max_cal, :health, :search_id

  @@all = {}

  def initialize(query_result,
                 search_id = nil,
                 query_term = nil,
                 max_cal = 500,
                 health = 'vegan')
    @query_result = query_result

    @query_term = query_term
    @max_cal = max_cal
    @health = health
    @search_id = search_id
    @@all[search_id] = self
  end

  def self.recent(search_id)
    @@all[search_id]
  end

  def filter_hits(disliked_list, hits)
    return if @query_result.nil?
    hits.reject do |hit|
      disliked_list.include?(hit['recipe']['label'])
    end
  end

  def query_error?
    return if @query_result.nil?
    @query_result == 403
  end

  def api_limit?
    return if @query_result.nil?
    @query_result == 401
  end

  def no_recipe_found?
    return if @query_result.nil?
    @query_result['count'] > 0 ? false : true
  end

  def num_of_hits
    return if @query_result.nil?
    @query_result['to']
  end

  def hits
    @query_result['hits'] if @query_result
  end
end

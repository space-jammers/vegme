module QueryResult
  attr_accessor :query_result, :query_term

  def self.store_query_result(query_result, query_term = nil)
    @query_result = query_result
    @query_term = query_term
  end

  def self.return_query_term
    @query_term
  end

  def self.query_error?
    return if @query_result.nil?
    @query_result == 403 ? true : false
  end

  def self.no_recipe_found?
    return if @query_result.nil?
    @query_result['count'] > 0 ? false : true
  end

  def self.hits
    @query_result['hits'] if @query_result
  end
end

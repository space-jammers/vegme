module QueryResult
  attr_accessor :query_result, :query_term

  def self.store_query_result(query_result, query_term = nil)
    @query_result = query_result
    @query_term = query_term
  end

  def self.return_query_result
    @query_result
  end

  def self.return_query_term
    @query_term
  end

  def self.result_created?
    @query_result.nil? ? false : true
  end

  def self.query_error?
    return if result_created? == false
    @query_result == 403 ? true : false
  end

  def self.no_recipe_found?
    return if result_created? == false
    @query_result['count'] > 0 ? false : true
  end
end

class QueryResult
  attr_accessor :query_result, :query_term

  def self.store_query_result(query_result, query_term)
    @query_result = query_result
    @query_term = query_term
  end

  def self.return_query_result
    @query_result
  end

  def self.return_query_term
    @query_term
  end
end

class QueryResult
  attr_accessor :query_result

  def self.store_query_result(query_result)
    @query_result = query_result
  end

  def self.return_query_result
    @query_result
  end
end

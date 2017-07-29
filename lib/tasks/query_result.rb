module QueryResult
  attr_accessor :query_result, :query_term, :limit, :max_cal

  def self.store_query_result(query_result,
                              query_term = nil,
                              limit = 1,
                              max_cal = 500)
    @query_result = query_result
    @query_term = query_term
    @limit = limit
    @max_cal = max_cal
  end

  def self.filter_hits(disliked_list, hits)
    return if @query_result.nil?
    hits.delete_if do |hit|
      disliked_list.include?(hit['recipe']['label'])
    end
  end

  def self.compare_hits(hits_count, filtered_hits)
    filter_count = hit_num(filtered_hits)
    comparison = hits_count <=> filter_count
    return comparison if comparison.zero?
    return hits_count - (hits_count - filter_count) if comparison == 1
  end

  def self.hit_num(hits)
    count = 0
    hits.each do
      count += 1
    end
    count
  end

  def self.return_query_term
    @query_term
  end

  def self.return_limit
    @limit
  end

  def self.return_max_cal
    @max_cal
  end

  def self.query_error?
    return if @query_result.nil?
    @query_result == 403
  end

  def self.no_recipe_found?
    return if @query_result.nil?
    @query_result['count'] > 0 ? false : true
  end

  def self.num_of_hits
    return if @query_result.nil?
    @query_result['to']
  end

  def self.hits
    @query_result['hits'] if @query_result
  end

  def self.api_limit?
    return if @query_result.nil?
    @query_result == 401
  end

  def self.clear_query
    @query_result = nil
    @query_term = nil
    @limit = nil
    @max_cal = nil
  end
end
# plan for when dislike count is greater than result count
# write tests

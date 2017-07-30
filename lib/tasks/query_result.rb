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

  def self.compare_hits(hits_count, dislikes)
    dislike_count = dislikes.length
    comparison = hits_count <=> dislike_count
    return hits_count if comparison.zero?
    return dislike_count if comparison == 1
  end

  def self.list_of_disliked(disliked_list, hits)
    return if @query_result.nil?
    hits.keep_if do |hit|
      disliked_list.include?(hit['recipe']['label'])
    end
  end

  # def self.each_dislike(hits)
  #   hits.each do |hit|
  #     puts hit['recipe']['label']
  #   end
  # end

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
end
# plan for when dislike count is greater than result count
# write tests
# error handling

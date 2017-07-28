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

  def self.filter_dislikes_from_results(disliked_recipes, hits)
    return if @query_result.nil?
    hits.each_with_index.map do |hit, index|
      disliked_recipes.include?(hit['recipe']['label']) ? hits.delete_at(index) : nil
    end
    hits
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

  def self.hits
    @query_result['hits'] if @query_result
  end

  def self.api_limit?
    return if @query_result.nil?
    @query_result == 401
  end
end

# have card disappear after dislike
# increase card number by amount of disliked items
# find a better place for disliked_recipes ?
# write tests

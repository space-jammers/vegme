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

  def self.filter_hits(disliked_recipes, hits)
    return if @query_result.nil?
    hits.each_with_index.map do |hit, index|
      disliked_recipes.include?(hit['recipe']['label']) ? hits.delete_at(index) : nil
    end
    hits
  end

  def self.compare_hits(hits_num, filtered_hits)
    comparison = hits_num <=> hit_num(filtered_hits)
    return comparison if comparison.zero?
    return hits_num - hit_num(filtered_hits) if comparison == 1
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
end

# have card disappear after dislike - done
# increase card number by amount of disliked items - done
# plan for when dislike count is greater than result count
# find a better place for disliked_recipes method and temp search comparison ?
# write tests

module QueryResult
  attr_accessor :query_result, :query_term, :max_cal

  def self.store_query_result(query_result,
                              query_term = nil,
                              max_cal = 500)
    @query_result = query_result
    @query_term = query_term
    @max_cal = max_cal
  end

  def self.filter_hits(disliked_list, hits)
    return if @query_result.nil?
    hits.reject do |hit|
      disliked_list.include?(hit['recipe']['label'])
    end
  end

  def self.hits_without_violations(violations, hits)
    return if @query_result.nil?
    hits.reject do |hit|
      violations.include?(hit)
    end
  end

  def self.filter_violation_recipes(health)
    return if @query_result.nil?
    @violations = []
    hits.each do |hit|
      ingredient_string = hit['recipe']['ingredientLines'].join(' ').downcase
      if health == 'vegetarian'
        AnimalProducts::ANTI_VEGETARIAN.any? do |ingredient|
          @violations.push(hit) if ingredient_string.include?(ingredient)
        end
      else
        AnimalProducts::ANTI_VEGAN.any? do |ingredient|
          @violations.push(hit) if ingredient_string.include?(ingredient)
        end
      end
    end
    @violations
  end

  def self.return_violations
    @violations
  end

  def self.return_query_term
    @query_term
  end

  def self.return_max_cal
    @max_cal
  end

  def self.query_error?
    return if @query_result.nil?
    @query_result == 403
  end

  def self.api_limit?
    return if @query_result.nil?
    @query_result == 401
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
end

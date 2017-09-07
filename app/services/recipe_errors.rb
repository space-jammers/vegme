module RecipeErrors
  attr_accessor :api_result

  def self.store_api_result(api_result)
    @api_result = api_result
  end

  def self.return_recipe_error
    @api_result
  end

  def self.api_limit?
    return if @api_result.nil?
    (400..600).include?(@api_result)
  end
end

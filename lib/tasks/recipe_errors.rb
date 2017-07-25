module RecipeErrors
  attr_accessor :api_result

  def self.store_api_result(api_result)
    @api_result = api_result
  end

  def self.return_recipe_error
    @api_result
  end

  def self.api_limit?
    @api_result == 401
  end
end

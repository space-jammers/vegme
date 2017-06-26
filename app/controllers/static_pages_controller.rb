class StaticPagesController < ApplicationController
  require 'recipe'
  def index
    @new_recipes = Recipe.new('apples', 3, 'vegetarian')
    @recipes = @new_recipes.search
    @recipe_names = []
    @recipes['hits'].each do |hit|
      @recipe_names.push(hit['recipe']['label'])
    end
  end
end

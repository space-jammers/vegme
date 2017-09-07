class QueriesController < ApplicationController
  def index
    query = QueryResult.recent(params[:search_id])
    return unless query
    flash_errors(query)
    return unless query.hits
    @recipes = signed_in? ? filter(query) : unfiltered(query)
  end

  def search
    QueryResult.remove(params[:old_id])
    verify_call(api_call)
    redirect_to queries_path(search_id: params[:search_id],
                             q: params[:q],
                             max_cal: params[:max_cal],
                             health: params[:health])
  end

  private

  def api_call
    GetRecipes.new(params[:q],
                   params[:max_cal],
                   params[:health])
  end

  def empty_query?
    /^\s*$/ =~ params[:q].to_s
  end

  def store(recipe_search)
    QueryResult.new(recipe_search,
                    params[:search_id])
  end

  def flash_errors(query)
    api_text = 'Oops! Looks like we are a bit busy...try again in a few minutes.'
    error_text = 'Oop! Looks like there was an error! Let us know about it in a suggestion comment and try again.'
    no_recipe_text = 'Oops! Looks like no recipes were found with those parameters. Try again.'
    return flash[:notice] = api_text if query.api_limit? || RecipeErrors.api_limit?
    return flash[:error] = error_text if query.query_error?
    return flash.now[:notice] = no_recipe_text if query.no_recipe_found?
    puts 'no errors'
  end

  def filter(query)
    query.filter_hits(current_user.disliked_recipes,
                      query.hits).paginate(params[:page],
                                           params[:anchor],
                                           9)
  end

  def unfiltered(query)
    query.hits.paginate(params[:page], params[:anchor], 9)
  end

  def verify_call(api_call)
    if empty_query?
      flash[:alert] = 'Oops! Looks like the search field was empty, please try again!'
    else
      store(api_call.search)
    end
  end
end

class QueriesController < ApplicationController
  def index
    query = QueryResult.recent(params[:search_id])
    return unless query
    flash_errors(query)
    return unless query.hits
    @recipes = signed_in? ? filter(query) : unfiltered(query)
  end

  def limbo
    render json: QueryResult.all_keys
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
    return flash.now[:notice] = 'API limit reached' if
      query.api_limit? || RecipeErrors.api_limit?
    return flash.now[:error] = 'error' if query.query_error?
    return flash.now[:notice] = 'no recipe found' if query.no_recipe_found?
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
      flash[:success] = 'Oops! Looks like the search field was empty, please try again!'
    else
      store(api_call.search)
    end
  end
end

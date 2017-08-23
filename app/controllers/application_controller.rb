class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :store_location, unless: :devise_controller?

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end

  def after_sign_up_path_for(*)
    queries_path
  end

  def after_sign_out_path_for(resource)
    stored_location_for(resource) || root_path
  end

  private

  def store_location
    # store last url - this is needed for post-login redirect to whatever the
    # user last visited.
    if request.fullpath != '/users/sign_in' &&
       request.fullpath != '/users/sign_up' &&
       request.fullpath != '/users/password' &&
       request.fullpath != '/users/sign_out' &&
       !request.xhr? # don't store ajax calls
      session['user_return_to'] = request.fullpath
    end
  end

  def authenticate_user_or_admin!
    if current_user.admin
      true
    else
      authenticate_user!
    end
  end

  def authenticate_admin!
    if current_user.admin
      authenticate_user!
    else
      redirect_to root_path
    end
  end
end

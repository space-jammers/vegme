class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :store_location, unless: :devise_controller?
  before_action :set_ie_engine

  def require_authorized_for_resource(resource)
    return if resource.nil?
    return if current_user.admin
    return if resource.user_id == current_user.id
    flash[:error] = 'Oops! That page is restricted'
    redirect_to root_path
  end

  private

  def set_ie_engine
    header = response.get_header('X-UA-Compatible')
    response.set_header('X-UA-Compatible', 'IE=Edge') if header.blank?
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end

  def after_sign_up_path_for(*)
    queries_path
  end

  def after_sign_out_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def feedback_params
    params.require(:feedback).permit(:label,
                                     :message,
                                     :link,
                                     :user_id,
                                     :admin_id,
                                     :complete)
  end

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

  def authenticate_admin!
    if signed_in?
      if current_user.admin
        authenticate_user!
      else
        redirect_to root_path
      end
    else
      redirect_to new_user_session_path
    end
  end
end

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name photo])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name photo])
  end

  # def set_current_order
  #   if session[:user_id]
  #     cookies[:order_id] = "test"
  #   end
  #   cookies[:order_id] =  ""
  # end

  protected

  # def after_sign_in_path_for(resource)
  #   session[:current_order] = "probando"
  #   byebug
  # end

  # def set_order
  #   cookies[:current_order] = "true"
  # end
end

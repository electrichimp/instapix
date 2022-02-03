class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :pending_order

  def pending_order
    if current_user
      pending_order = current_user.orders.where(state: "pending").take || nil
      pending_order = current_user.orders.create(state: "pending") unless pending_order.present?
      return pending_order
    end
  end

  protected

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name photo])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name photo])
  end

  def after_sign_in_path_for(resource)
    # pending_order = current_user.orders.where(state: "pending").first
    # session[:current_order] = pending_order || Order.create(state: "pending") if user_signed_in?
    # stored_location_for(resource) || root_path
    stored_location_for(resource) || root_path
  end
end

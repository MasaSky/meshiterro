class ApplicationController < ActionController::Base
  before_action :configure_authentication
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_authentication
    if admin_controller?
      authenticate_admin!
    else
      authenticate_user! unless public_controller?
    end
  end

  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end

  def public_controller?
    self.class.module_parent_name == 'Public'
  end

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
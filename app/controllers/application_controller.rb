class ApplicationController < ActionController::Base    
    protect_from_forgery with: :null_session
    before_action :configure_permitted_parameters, if: :devise_controller?
    
  protected

  def configure_permitted_parameters
    # Permit the `subscribe_newsletter` parameter along with the other
    # sign up parameters.

    devise_parameter_sanitizer.permit(:signup, keys:  [:username, :email, :password, :password_confirmation])
    
  end
end

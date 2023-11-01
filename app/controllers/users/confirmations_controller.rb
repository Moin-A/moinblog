class Users::ConfirmationsController < Devise::ConfirmationsController
    protect_from_forgery with: :null_session 
    before_action :configure_permitted_parameters
    def show
        super do |resource|
          sign_in(resource) if resource.errors.empty?    
          if resource.errors.empty?
            redirect_to  ENV['ALLOWED_FRONTEND_HOSTS'] ,allow_other_host: true and return
          else
            redirect_to ENV['ALLOWED_FRONTEND_HOSTS'], allow_other_host: true and     return
          end
        end
      end

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:params, keys: [:first_name, :last_name])
      end   
end
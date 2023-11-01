# backend/app/controllers/users_invitations_controller.rb
class Users::PasswordsController < Devise::PasswordsController
    before_action :authenticate_user! 
    
     
      def create
        super do |resource|
            if resource.errors.empty?
               render json: {
            status: {message: "password reset email sent"}
          }, status: 200 and return
            else
              render json: {
            status: {message: "password reset failed. #{resource.errors.full_messages.to_sentence}"}
          }, status: :unprocessable_entity and return
            end
          end
      end  

      def edit  
        self.resource = resource_class.new
        set_minimum_password_length
        resource.reset_password_token = params[:reset_password_token]
       
      end
      def update
        super do |resource|
          if resource.errors.empty?  
            token = Warden::JWTAuth::UserEncoder.new.call(@user, :user, nil)
            response.headers['Authorization'] = "Bearer #{token[0]}"                               
            render json: { status: { message:"Invitation Accepted!" ,
            data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
            code:200
            }}, status: 200 and return
          else
            render json: {
          status: {message: "#{resource.errors.full_messages.to_sentence}"}
        }, status: :unprocessable_entity and return
          end
        end
      end




     private
     def password_resource_params
      params.require(:user).permit(:password,:reset_password_token,:password_confirmation)
     end
 
     def update_params
       params.require(:user).permit(:password, :password_confirmation)
     end

     

    end
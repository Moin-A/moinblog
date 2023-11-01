# backend/app/controllers/users_invitations_controller.rb
class Users::InvitationsController < Devise::InvitationsController
  protect_from_forgery with: :null_session 
  before_action :configure_permitted_parameters
   
    def edit
      sign_out send("current_#{resource_name}") if send("#{resource_name}_signed_in?")
      set_minimum_password_length
      resource.invitation_token = params[:invitation_token]
      redirect_to "http://localhost:3005/signin?invitation_token=#{params[:invitation_token]}&email=#{resource[:email]}"
    end
    def create
      super do |resource|
        if resource.errors.empty?
           render json: {
        status: {message: "Invitation sent"}
      }, status: 200 and return
        else
          render json: {
        status: {message: "Invitation can't be sent. #{resource.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity and return
        end
      end
    end
    def update
      super do |resource|
        if resource.errors.empty?
          sign_in(resource)
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
    def invite_resource_params
      params.require(:user).permit(:email, :first_name, :last_name,:invitation_token,:password)
    end
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation, keys: [:first_name, :last_name])
    end
  end
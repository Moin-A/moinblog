# frozen_string_literal: true
require 'pry'
class Users::RegistrationsController < Devise::RegistrationsController

  respond_to :json


  def new
    self.resource = resource_class.new    
  end
  private
  def respond_with(resource, _opts = {})
  
    if resource.persisted?
      resource.build_member_detail.save
      render json: {
        status: {code: 402, message: 'please confirm verification link sent to registered email.'},
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: {message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, member_detail_attributes:[:role, :biography, :social_media_links ,:status ])
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :first_name, :last_name)
  end

end

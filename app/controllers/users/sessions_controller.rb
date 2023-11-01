# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  
  protect_from_forgery with: :null_session
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
  end

  def authenticate_user    
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    
    if request.headers['X-Request-Source']==="Client"
          
          render json: {
            status: {code: 200, message: 'Logged in sucessfully.'},
            data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
          }, status: :ok
          else 
            respond_to do |format|
            format.html { redirect_to edit_member_detail_path(resource) }
            format.json { render json: { status: { code: 200, message: 'Logged in successfully.' }, data: UserSerializer.new(resource).serializable_hash[:data][:attributes] }, status: :ok }
          end
    end      
    
  end  

  # POST /resource/sign_in
  def create    
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    
    if request.headers['X-Request-Source']==="Client"
          
          render json: {
            status: {code: 200, message: 'Logged in sucessfully.'},
            data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
          }, status: :ok
          else 
            respond_to do |format|
            format.html { redirect_to edit_member_detail_path(resource) }
            format.json { render json: { status: { code: 200, message: 'Logged in successfully.' }, data: UserSerializer.new(resource).serializable_hash[:data][:attributes] }, status: :ok }
          end
    end      
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out

    respond_to do |format|
      format.html { redirect_to after_sign_out_path_for(resource_name) }
      format.json { render json: { status: 200, message: 'Logged out successfully' }, status: :ok }
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  respond_to :json
  private

  def respond_with(resource, _opts = {})
  
    render json: {
      status: {code: 200, message: 'Logged in sucessfully.'},
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  def respond_to_on_destroy
      render json: {
        status: 200,
        message: "logged out successfully"
      }, status: :ok   
  end
  def log_in_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end

end

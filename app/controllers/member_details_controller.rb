class MemberDetailsController < ApplicationController 
  before_action :authenticate_user!
  before_action :set_user_id, except:[:update]   
  def member_detail_params
    params.require(:member_detail).permit(:status, :role, :avatar, :biography, :social_media_links)
  end

  def show  
    user_id = params[:id].to_i
    @memberdetail = MemberDetail.where({id: params[:id]}).first

    if @memberdetail.nil?    
      render json: { error: "member details not found" }, status: :not_found     
    else                   
      render json: {
        status: {code: 200, message: 'ok.'},
        data: MemberDetailSerializer.new(@memberdetail).serializable_hash[:data][:attributes],
      }, status: :ok
    end     
  end
  
  def set_user_id
    @user_id=User.friendly.find(params["id"])["id"]
  end  

  def edit       
   
    @member = MemberDetail.find_by(user_id:@user_id)
  end  
  def set_filename
    
  end
  def update                 
     @member_detail = MemberDetail.find_by(user_id: current_user.id)        
     
       if @member_detail.update(member_detail_params)
         render json: {
        status: {code: 200, message: 'ok.'},
        data: MemberDetailSerializer.new(@member_detail).serializable_hash[:data][:attributes],
      }, status: :ok
       else
        render json: { error: "unprocessible entity" }, status: :not_found     
       end     
   end
end

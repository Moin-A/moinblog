class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :created_at,:first_name,:last_name
  
  attributes :member_details do |object|       
    MemberDetailSerializer.new(object.member_detail).serializable_hash[:data][:attributes]
  end

end

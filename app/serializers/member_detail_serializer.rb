class MemberDetailSerializer 
    include FastJsonapi::ObjectSerializer
    attributes :role, :biography, :social_media_links, :status 
        attributes :avatar do |object| 
            
          unless object.avatar.blob.nil?
            object.avatar.blob.url.split("?").first
          end
        end
  end
  
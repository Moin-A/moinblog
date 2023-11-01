class PostSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :created_at, :title ,:summary

    attributes :body do |object|        
        object.content.to_s.gsub(/\A<div class="trix-content">(.*)<\/div>\z/m, '\1').strip.html_safe
    end

    attributes :heroimage do |object|  
        unless object.heroimage.nil?           
            object.heroimage.url&.split("?")&.first
        end
    end

    attributes :tags do |object|
        object.tags
    end
    attributes :Author do |object|
        {
            name: object.user.first_name + " " + object.user.last_name,
            id: object.user.id,
            avatar:object.user.member_detail.avatar.url&.split("?")&.first
        }
    end

end
  
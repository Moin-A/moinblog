require 'pry'
class CommentSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :content, :created_at,:post_id

    attributes :user_info do |comment|       
        UserSerializer.new(comment.user).as_json['data']['attributes']
    end
end
  
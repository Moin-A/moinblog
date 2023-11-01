module MemberDetailsHelper
    def avatar_helper(user)        
        avatar_image =  @member&.avatar&.url&.split("?")&.first || gravatar_url
        image_tag(avatar_image, width: 45, height: 45, class: "profile-image")
      end
      def gravatar_url
        "https://gravatar.com/avatar/f2709d75b2a3868b82f5f52947410304?s=400&d=robohash&r=x"
      end
end

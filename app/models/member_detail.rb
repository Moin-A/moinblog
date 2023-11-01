class MemberDetail < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar, dependent: :purge_later
  before_save :set_correct_attachment_filenames

  def set_correct_attachment_filenames
    if self.avatar.attached?
      ActiveRecord::Base.transaction do
        begin
          self.avatar.blob.update(key: "AvatarImage_User-#{user_id}.#{self.avatar.filename.extension}")
        rescue => e
          # Handle the exception, e.g., log the error or take appropriate action
          # You can use this for debugging
        end
      end
    end
  end
  
 
  
end

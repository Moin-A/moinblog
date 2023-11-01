class Post < ApplicationRecord
    extend FriendlyId
    belongs_to :user
    has_rich_text :content
    has_many_attached :photos
    has_many :post_tags ,dependent: :destroy
    has_many :comments
    has_many :tags, :through => :post_tags
    has_one_attached :heroimage
    friendly_id :title, use: %i[slugged history]

    def should_generate_new_friendly_id?
        title_changed? || slug.blank?
    end   
    
end

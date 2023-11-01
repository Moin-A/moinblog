class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_one :member_detail  
  has_many :post
  has_many :comments
  accepts_nested_attributes_for :member_detail, allow_destroy: true
  extend FriendlyId
  friendly_id :first_name, use: %i[slugged history]
  devise :invitable, :database_authenticatable,:confirmable, :registerable, :validatable, :recoverable,
         :omniauthable,:jwt_authenticatable, jwt_revocation_strategy: self    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    def jwt_payload
        super.merge('foo' => 'bar')
      end
    validates :email, presence: true,format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: {minimum: 10}
    validates :first_name, presence: true
    validates :last_name, presence: true  
    def send_devise_notification(notification, *args)
      devise_mailer.send(notification, self, *args).deliver_later
    end
    def should_generate_new_friendly_id?
      first_name_changed? || slug.blank?
   end  
    def self.from_omniauth(auth)
      where(email: auth.info.email).first_or_create do |user|
        user.email = auth.info.email
        user.provider = auth.provider
        user.password = Devise.friendly_token[0,20]
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.uid=auth.info.uid
        user.skip_confirmation! 
        user.build_member_detail.save             
    end      
end
def self.new_with_session(params,session)
  super.tap do |user|
    if data = session["devise.github"] && session["devise.github_data"]["extra"]["raw_info"]
       user.email = data["email"] if user.email.blank?
    end
    if data = session["devise.google_oauth2"] && session["devise.google_oauth2_data"]["extra"]["raw_info"]
      user.email = data["email"] if user.email.blank?
    end
  end  
end
end   

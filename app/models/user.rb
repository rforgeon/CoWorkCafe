class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  validates :name, presence: true

  #->Prelang (user_login/devise)
  has_many :reviews
  has_many :workers
  has_many :owners
  has_many :caves
  has_many :customers, class_name: "Session", foreign_key: "seller_id"
  has_many :mysessions, class_name: "Session", foreign_key: "buyer_id"
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "https://dl.dropboxusercontent.com/s/v5sjdcrg107sxfq/userNoImage.png?dl=0"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/, size: { in: 0..1000.kilobytes }
  #fix image sizes with http://www.peoplecancode.com/tutorials/users-avatars-uploading-images-using-paperclip


  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first

    # The User was found in our database
    return user if user

    # Check if the User is already registered without Facebook
    user = User.where(email: auth.info.email).first

    return user if user

    # The User was not found and we need to create them
    User.create(name:     auth.extra.raw_info.name,
                provider: auth.provider,
                uid:      auth.uid,
                email:    auth.info.email,
                password: Devise.friendly_token[0,20])
  end


end

class Cafe < ActiveRecord::Base
  belongs_to :user
  has_many :sessions

  if Rails.env.development?
    has_attached_file :image, styles: { medium: "200x", thumb: "100x100>" }, default_url: "noImage.png"

    validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  else
  has_attached_file :image, styles: { medium: "200x", thumb: "100x100>" }, default_url: "noImage.png",
                    :storage => :dropbox,
                    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                    :path => ":style/:id_:filename"

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  end

  validates :name, :description, :address, :city, :state, presence: true

end

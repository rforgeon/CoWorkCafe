class Cafe < ActiveRecord::Base
  belongs_to :user
  has_many :sessions
  has_many :reviews
  has_many :images

  if Rails.env.development?
    has_attached_file :image, styles: { medium: "200x", thumb: "100x100>" }, default_url: "https://dl.dropboxusercontent.com/s/0skshx790a4mzy5/noImage.png?dl=0"

    validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  else
  has_attached_file :image, styles: { medium: "200x", thumb: "100x100>" }, default_url: "https://dl.dropboxusercontent.com/s/0skshx790a4mzy5/noImage.png?dl=0",
                    :storage => :dropbox,
                    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                    :path => ":style/:id_:filename"

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"], size: { in: 0..1000.kilobytes }
  end

  validates :name, :description, :address, :city, :state, presence: true

end

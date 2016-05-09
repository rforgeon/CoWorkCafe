class Image < ActiveRecord::Base

  belongs_to :cafe

  if Rails.env.development?
    has_attached_file :cafephoto, styles: { medium: "200x", thumb: "100x100>" }, default_url: "noImage.png"

    validates_attachment_content_type :cafephoto, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  else
  has_attached_file :cafephoto, styles: { medium: "200x", thumb: "100x100>" }, default_url: "noImage.png",
                    :storage => :dropbox,
                    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                    :path => ":style/:id_:filename"

  validates_attachment_content_type :cafephoto, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  end

end

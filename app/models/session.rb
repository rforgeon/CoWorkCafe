class Session < ActiveRecord::Base

  belongs_to :cafe
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"

end

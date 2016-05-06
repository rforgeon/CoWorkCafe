class AddAttachmentCafephotoToImages < ActiveRecord::Migration
  def self.up
    change_table :images do |t|
      t.attachment :cafephoto
    end
  end

  def self.down
    remove_attachment :images, :cafephoto
  end
end

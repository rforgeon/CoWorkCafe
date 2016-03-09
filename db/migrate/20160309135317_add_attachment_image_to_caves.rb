class AddAttachmentImageToCaves < ActiveRecord::Migration
  def self.up
    change_table :caves do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :caves, :image
  end
end

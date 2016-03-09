class AddUserIdToCaves < ActiveRecord::Migration
  def change
    add_column :caves, :user_id, :integer
  end
end

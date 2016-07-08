class AddOwnercutToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ownercut, :integer
  end
end

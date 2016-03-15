class AddFieldsToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :buyer_id, :integer
    add_column :sessions, :seller_id, :integer
  end
end

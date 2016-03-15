class AddCafeIdToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :cafe_id, :integer
  end
end

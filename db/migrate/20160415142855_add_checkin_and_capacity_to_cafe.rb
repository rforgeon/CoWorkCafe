class AddCheckinAndCapacityToCafe < ActiveRecord::Migration
  def change
    add_column :caves, :checkin, :text
    add_column :caves, :capacity, :integer
  end
end

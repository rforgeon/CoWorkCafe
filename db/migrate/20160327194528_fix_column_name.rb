class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :reviews, :restaurant_id, :cafe_id
  end
end

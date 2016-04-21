class AddRateToCafe < ActiveRecord::Migration
  def change
    add_column :caves, :rate, :decimal
  end
end

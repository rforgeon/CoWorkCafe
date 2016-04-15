class AddPhoneToCafe < ActiveRecord::Migration
  def change
    add_column :caves, :phone, :string
  end
end

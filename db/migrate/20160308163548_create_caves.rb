class CreateCaves < ActiveRecord::Migration
  def change
    create_table :caves do |t|
      t.string :name
      t.text :description
      t.text :address
      t.string :city
      t.string :state
      t.integer :zipcode

      t.timestamps
    end
  end
end

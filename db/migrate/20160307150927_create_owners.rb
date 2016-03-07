class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.references :user, index: true
      t.string :address
      t.string :state
      t.string :city
      t.integer :zipcode
      t.text :description
      t.float :rating

      t.timestamps
    end
  end
end

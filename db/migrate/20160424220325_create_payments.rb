class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.integer :user_id
      t.integer :stripe_id

      t.timestamps
    end
  end
end

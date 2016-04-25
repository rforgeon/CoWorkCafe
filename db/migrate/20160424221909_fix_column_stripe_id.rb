class FixColumnStripeId < ActiveRecord::Migration
  def up
     remove_column :payments, :stripe_id
   end

   def down
     add_column :payments, :stripe_id, :string
   end
end

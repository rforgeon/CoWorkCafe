class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.references :user, index: true
      t.integer :count

      t.timestamps
    end
  end
end

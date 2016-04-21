class AddCreditToUsers < ActiveRecord::Migration
  def change
    add_column :users, :Credits, :decimal
  end
end

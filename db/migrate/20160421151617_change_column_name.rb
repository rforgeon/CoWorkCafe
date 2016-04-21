class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :Credits, :credit
  end
end

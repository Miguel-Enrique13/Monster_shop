class AddColumnToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :status, :string, :default => 'Pending'
  end
end

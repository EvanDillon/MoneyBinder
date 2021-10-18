class AddContraToAccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :contra, :boolean, default: false
  end
end

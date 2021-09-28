class ChangeAccountNumberName < ActiveRecord::Migration[6.1]
  def change
    rename_column :accounts, :number, :account_number
  end
end

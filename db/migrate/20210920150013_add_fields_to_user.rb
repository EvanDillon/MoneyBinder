class AddFieldsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :loginAttempts,      :integer,  default: 0
    add_column :users, :suspendedTill,      :datetime, default: nil
  end
end

class AddColumnsToUserTable < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :userType,      :integer,  default: 3
    add_column :users, :firstName,     :string 
    add_column :users, :lastName,      :string
    add_column :users, :dob,           :date
    add_column :users, :email,         :string
    add_column :users, :phoneNum,      :string
    add_column :users, :address,       :string
    add_column :users, :passUpdatedAt, :datetime, default: Time.zone.now
    add_column :users, :active,        :boolean,  default: 'true'
  end
end

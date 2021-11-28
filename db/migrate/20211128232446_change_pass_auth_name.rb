class ChangePassAuthName < ActiveRecord::Migration[6.1]
  def change
    rename_table :password_authorizations, :password_join_authorizations
  end
end

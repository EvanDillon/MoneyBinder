class PasswordAuthorization < ActiveRecord::Migration[6.1]
  def change
    create_table :password_authorizations do |t|
      t.references :user, foreign_key: true
      t.references :password_question, foreign_key: true
      t.string :answer

      t.timestamps null: false
    end
  end
end

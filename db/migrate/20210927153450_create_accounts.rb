class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.belongs_to :user,         index: true, foreign_key: true
      t.text :name,             null: false
      t.integer :number,          null: false
      t.text :description,      null: true
      t.text :normal_side
      t.text :category
      t.text :subcategory
      t.integer :initial_balance, default: 0
      t.integer :debit,           default: 0
      t.integer :credit,          default: 0
      t.integer :balance,         default: 0
      t.text :order
      t.text :statement
      t.text :comment,            null: true
      t.boolean :active,          default: true

      t.timestamps null: false
    end
  end
end

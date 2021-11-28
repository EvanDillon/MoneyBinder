class CreateErrorMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :error_messages do |t|
      t.text :error_name
      t.text :body
      t.timestamps
    end
  end
end

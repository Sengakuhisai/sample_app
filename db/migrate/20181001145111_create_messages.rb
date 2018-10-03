class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :to_id
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :messages,:user_id
    add_index :messages,:to_id
    add_index :messages,[:user_id,:created_at]
    add_index :messages,[:to_id,:created_at]
  end
end

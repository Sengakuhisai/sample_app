class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :from_id
      t.integer :to_id
      t.string :content

      t.timestamps
    end
    add_index :messages,:from_id
    add_index :messages,:to_id
    add_index :messages,[:from_id,:created_at]
    add_index :messages,[:to_id,:created_at]
  end
end

class CreatePurses < ActiveRecord::Migration
  def self.up
    create_table :purses do |t|
      t.integer :user_id
      t.integer :currency_id
      t.float :content

      t.timestamps
    end
    add_index :purses, :user_id
    add_index :purses, :currency_id
    add_index :purses, [:user_id, :currency_id], :unique => true
  end

  def self.down
    drop_table :purses
  end
end

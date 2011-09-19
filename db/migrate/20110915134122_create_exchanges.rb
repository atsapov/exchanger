class CreateExchanges < ActiveRecord::Migration
  def self.up
    create_table :exchanges do |t|
      t.integer :bought_id
      t.integer :sold_id
      t.float :rate

      t.timestamps
    end
  end

  def self.down
    drop_table :exchanges
  end
end

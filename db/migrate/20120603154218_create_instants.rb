class CreateInstants < ActiveRecord::Migration
  def self.up
    create_table :instants do |t|

      t.string  :dbname
      t.string  :title
      t.string  :description
      t.string  :notes
      t.string  :url
      t.integer :version

      t.timestamps
    end
  end

  def self.down
    drop_table :instants
  end
end

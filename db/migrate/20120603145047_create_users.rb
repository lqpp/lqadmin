class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|

      t.string :email
      t.string :pass
      t.string :sig
      t.string :note
      t.boolean :admin , :defautl => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

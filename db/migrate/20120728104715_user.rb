class User < ActiveRecord::Migration
  def self.up
     add_column :users, :accessall, :boolean, :defautl => false
  end

  def self.down
    remove_column :users, :accessall
  end
end

class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table :logs do |t|

      t.integer  :user_id
      t.integer  :instants_id
      t.string   :action
      t.string   :parameters

      t.timestamps
    end
  end

  def self.down
    drop_table :logs
  end
end

class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|

      t.integer :user_id
      t.integer :instants_id

      # PERMISSIONS
      # queries
      # Format: bla_search_result
      t.boolean :search_fulltext_yesno, :default => false
      t.boolean :search_fulltext_username, :default => false
      t.boolean :search_fulltext_userid, :default => false
      t.boolean :search_fulltext_fulldetails, :default => false
      
      t.boolean :check_invite_status, :default => false
      t.boolean :check_invite_username, :default => false
      t.boolean :check_invite_userid, :default => false

      #actions
      t.boolean :invitecode_sendusermail, :default => false # send mail with username to user-email
      t.boolean :username_sendfreetextemail, :default => false # via form
      
      t.boolean :invitecode_disable, :default => false
      t.boolean :invitecode_create, :default => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :permissions
  end
end

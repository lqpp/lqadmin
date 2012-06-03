class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|

      t.integer :user_id
      t.integer :instants_id

      # PERMISSIONS
      # queries
      # Format: bla_search_result
      t.boolean :search_fulltext_yesno
      t.boolean :search_fulltext_username
      t.boolean :search_fulltext_userid
      t.boolean :search_fulltext_fulldetails
      
      t.boolean :check_invite_status
      t.boolean :check_invite_username
      t.boolean :check_invite_userid

      #actions
      t.boolean :invitecode_sendusermail # send mail with username to user-email
      t.boolean :username_sendfreetextemail # via form
      t.boolean :invitecode_disable
      t.boolean :invitecode_create
      
      t.timestamps
    end
  end

  def self.down
    drop_table :permissions
  end
end

class Instants < ActiveRecord::Base
  has_many :permissions, :dependent => :delete_all
end

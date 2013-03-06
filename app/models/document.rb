class Document < ActiveRecord::Base
  
  attr_accessible :filename, :name, :user_id, :referrer
  mount_uploader :filename, DocFileUploader
  
  belongs_to :user
  
  validates_presence_of :filename, :user_id
  
end

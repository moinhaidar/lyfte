class Document < ActiveRecord::Base
  
  attr_accessible :filename, :name, :user_id, :referrer
  mount_uploader :filename, DocumentUploader
  
  belongs_to :user
  
  validates_presence_of :filename, :user_id
  
  class << self
    
    def get_original_filename(asset)
      File.basename(asset)
    end
    
    def get_byte_stream(asset)
      #asset = '/home/trantor/Downloads/image.jpg'
      img = File.open(asset) {|i| i.read}
      Base64.encode64(img)
    end
    
    def upload_by_stream(byte_stream, org_filename, ref = nil, user_id = nil)
      user = User.find_by_id(user_id) || User.first
      encoded_img = byte_stream
      doc = Document.new(:user_id => user.id, :referrer => ref)
      io = LyfteStringIO.new(Base64.decode64(encoded_img))
      io.original_filename = org_filename
      doc.filename = io
      doc.save
    end
    
  end
  
  def upload_by_asset_path(user, asset_path)
    self.user_id = user.id
    self.filename = File.open(asset_path)
    self.save
  end
  
end

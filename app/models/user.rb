class User < ActiveRecord::Base
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :mobile, :age, :sex, :address, :referer
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  validates :name, :presence => true, :length => { :minimum => 2 }
  validates :mobile, :presence => true
  validates :referer, :presence => true
  validates :age, :numericality => { :only_integer => true, :greater_than => 17 }, :if => Proc.new { |u| !u.age.blank? }
  
  before_create :create_registeration_token
  
  def self.registeration_url(email)
    user = User.find_by_email(email)
    return nil unless user
    r_token = BCrypt::Engine.hash_secret(user.email, user.salt)
    r_token == user.registeration_token ? r_token : nil
  end
  
  private
  
  def create_registeration_token
    self.salt = BCrypt::Engine.generate_salt
    self.registeration_token = BCrypt::Engine.hash_secret(email, salt)
  end
  
end

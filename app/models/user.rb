# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  address                :text
#  age                    :integer
#  sex                    :string(255)
#  mobile                 :string(255)
#  referer                :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  salt                   :string(255)
#  registeration_token    :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

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
  
  has_many :documents
  
  before_create :create_registeration_token
  
  #TODO: Tweak per se requirement
  def self.registeration_url(email)
    user = User.find_by_email(email)
    return nil unless user
    r_token = BCrypt::Engine.hash_secret(user.email, user.salt)
    r_token == user.registeration_token ? r_token : nil
  end
  
  private
  
  #TODO: Tweak per se requirement
  def create_registeration_token
    self.salt = BCrypt::Engine.generate_salt
    self.registeration_token = BCrypt::Engine.hash_secret(email, salt)
  end
  
end

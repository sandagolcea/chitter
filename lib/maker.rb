require 'bcrypt'
require "dm-validations"

class Maker
  
  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  property :id,     Serial 
  property :name,  String
  property :user_name,  String, :unique => true, :message => "This user name is already taken"
  property :email,  String, :unique => true, :message => "This email is already taken"
  property :password_digest,  Text
  validates_confirmation_of :password, :message => "Sorry, your passwords don't match"

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

#Sample User
User.where( 
  :email => 'admin@lyfte.com'
).first_or_create(
  :name => 'Admin',
  :password => 'Passw0rd',
  :password_confirmation => 'Passw0rd',
  :mobile => '9999999999',
  :referer => 'Trantor Inc'
)

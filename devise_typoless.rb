# >--------------------------------[ Devise ]---------------------------------<

# Utilize Devise for authentication, automatically configured for your selected ORM.
say_recipe 'Devise'

gem 'devise'

after_bundler do
  generate 'devise:install'

  say_recipe "template['orm'] is #{template['orm']}"

  gsub_file 'config/initializers/devise.rb', 'devise/orm/active_record', 'devise/orm/mongoid'

  generate 'devise user'

end
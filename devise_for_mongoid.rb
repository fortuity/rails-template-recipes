# >--------------------------------[ Devise for Mongoid ]---------------------------------<

# Utilize Devise for authentication, configured for Mongoid.
say_recipe 'Devise'

gem 'devise'

after_bundler do
  generate 'devise:install'

  gsub_file 'config/initializers/devise.rb', 'devise/orm/active_record', 'devise/orm/mongoid'

  generate 'devise user'

end
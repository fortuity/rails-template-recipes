# >--------------------------------[ Devise ]---------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/devise.rb

# This recipe replaces the RailsWizard standard Devise recipe which has an error as of 18 Feb 2011:
# https://github.com/intridea/rails_wizard/issues#issue/13

# Utilize Devise for authentication, automatically configured for your selected ORM.
say_recipe 'Devise'

gem "devise", ">= 1.2.0"

after_bundler do

  #----------------------------------------------------------------------------
  # Run the Devise generator
  #----------------------------------------------------------------------------
  generate 'devise:install'

  if recipe_list.include? 'mongo_mapper'
    gem 'mm-devise'
    gsub_file 'config/initializers/devise.rb', 'devise/orm/active_record', 'devise/orm/mongo_mapper_active_model'
  elsif recipe_list.include? 'mongoid'
    # Nothing to do (Devise changes its initializer automatically when Mongoid is detected)
    # gsub_file 'config/initializers/devise.rb', 'devise/orm/active_record', 'devise/orm/mongoid'
  elsif recipe_list.include? 'active_record'
    # Nothing to do
  else
    # Nothing to do
  end

  #----------------------------------------------------------------------------
  # Prevent logging of password_confirmation
  #----------------------------------------------------------------------------
  gsub_file 'config/application.rb', /:password/, ':password, :password_confirmation'

  if extra_recipes.include? 'git'
    git :tag => "devise_installation"
    git :add => '.'
    git :commit => "-am 'Added Devise for authentication.'"
  end

  #----------------------------------------------------------------------------
  # Generate models and routes for a User
  #----------------------------------------------------------------------------
  generate 'devise user'

  if extra_recipes.include? 'git'
    git :tag => "devise_user"
    git :add => '.'
    git :commit => "-am 'Devise generated models and routes for a User.'"
  end

end
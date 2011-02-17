# >--------------------------------[ Devise ]---------------------------------<

# Utilize Devise for authentication, automatically configured for your selected ORM.
say_recipe 'Devise'

gem 'devise'

after_bundler do
  generate 'devise:install'

  # the case statement is cleaner but fails evaluating template['orm']
  # case template['orm']
  #   when 'mongo_mapper'
  #     gem 'mm-devise'
  #     gsub_file 'config/initializers/devise.rb', 'devise/orm/active_record', 'devise/orm/mongo_mapper_active_model'
  #   when 'mongoid'
  #     gsub_file 'config/initializers/devise.rb', 'devise/orm/active_record', 'devise/orm/mongoid'
  #   when 'active_record'
  #     # Nothing to do
  # end
  
  if recipe_list.include? 'mongo_mapper'
    gem 'mm-devise'
    gsub_file 'config/initializers/devise.rb', 'devise/orm/active_record', 'devise/orm/mongo_mapper_active_model'
  elsif recipe_list.include? 'mongoid'
    gsub_file 'config/initializers/devise.rb', 'devise/orm/active_record', 'devise/orm/mongoid'
  elsif recipe_list.include? 'active_record'
    # Nothing to do
  else
    # Nothing to do
  end
 
  if recipe_list.include? 'haml'
    # the following gems are used to generate Devise views for Haml
    gem 'hpricot', :group => :development
    gem 'ruby_parser', :group => :development
  end
  
  generate 'devise user'
  
  if extra_recipes.include? 'git'
    say_wizard "commiting Devise updates to git"
    git :add => '.'
    git :commit => "-am 'Added Devise for authentication'"
  end
  
end
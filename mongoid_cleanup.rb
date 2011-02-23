# >--------------------------------[ mongoid_cleanup ]--------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/mongoid_cleanup.rb

say_recipe 'Mongoid Cleanup'

if recipe_list.include? 'mongoid'

  # update to a newer Mongoid version
  gsub_file 'Gemfile', /"mongoid", ">= 2.0.0.beta.19"/, '"mongoid", ">= 2.0.0.rc.7"'

  # modifying 'config/application.rb' file to remove ActiveRecord dependency
  gsub_file 'config/application.rb', /require 'rails\/all'/ do
  <<-RUBY
  require 'action_controller/railtie'
  require 'action_mailer/railtie'
  require 'active_resource/railtie'
  require 'rails/test_unit/railtie'
  RUBY
  end

  # remove unnecessary 'config/database.yml' file
  remove_file 'config/database.yml'

  if extra_recipes.include? 'git'
    say_wizard "commiting changes to git"
    git :add => '.'
    git :commit => "-am 'Fix config/application.rb file to remove ActiveRecord dependency.'"
  end

end
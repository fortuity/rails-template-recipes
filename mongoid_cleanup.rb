# >--------------------------------[ mongoid_cleanup ]--------------------------------<

say_recipe 'Mongoid cleanup'

if recipe_list.include? 'mongoid'

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
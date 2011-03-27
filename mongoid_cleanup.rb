# >--------------------------------[ mongoid_cleanup ]--------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/mongoid_cleanup.rb

say_recipe 'Mongoid Cleanup'

if recipe_list.include? 'mongoid'

  # update to a newer Mongoid version
  gsub_file 'Gemfile', /"mongoid", ">= 2.0.0.beta.19"/, '"mongoid", ">= 2.0.0.rc.8"'

  # note: the mongoid generator automatically modifies the config/application.rb file
  # to remove the ActiveRecord dependency by commenting out "require active_record/railtie'"

  # remove unnecessary 'config/database.yml' file
  remove_file 'config/database.yml'

  if extra_recipes.include? 'git'
    git :tag => "mongoid_cleanup"
    git :add => '.'
    git :commit => "-am 'use newer Mongoid gem and remove database.yml file.'"
  end

end
# >--------------------------------[ mongoid_cleanup ]--------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/mongoid_cleanup.rb

say_recipe 'Mongoid Cleanup'

if recipe_list.include? 'mongoid'

  # update to a newer Mongoid version
  gsub_file 'Gemfile', /"mongoid", ">= 2.0.0.beta.19"/, '"mongoid", ">= 2.0.0.rc.7"'

  # note: the mongoid generator automatically modifies the config/application.rb file
  # to remove the ActiveRecord dependency by commenting out "require active_record/railtie'"

  # remove unnecessary 'config/database.yml' file
  remove_file 'config/database.yml'

  #----------------------------------------------------------------------------
  # Change YAML Engine to accommodate Ruby 1.9.2p180 yaml parser problem.
  # Rubygems 1.5.0 changes the yaml parsing default from syck 
  # to psych and psych doesn't like the ":<<" in yaml files.
  # This is a workaround until the next version of Ruby is published.
  # http://groups.google.com/group/mongoid/browse_thread/thread/9213a17a73d3c422
  # http://redmine.ruby-lang.org/issues/show/4300
  #----------------------------------------------------------------------------                         
  inject_into_file 'config/environment.rb', "\nrequire 'yaml'\nYAML::ENGINE.yamler= 'syck'\n", :after => "require File.expand_path('../application', __FILE__)", :verbose => false

  if extra_recipes.include? 'git'
    git :tag => "mongoid_cleanup"
    git :add => '.'
    git :commit => "-am 'use newer Mongoid gem and remove database.yml file.'"
  end

end
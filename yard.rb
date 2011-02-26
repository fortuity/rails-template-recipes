# >---------------------------------[ Yard ]----------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/yard.rb

# Replaces RDoc with Yard for documentation.

if recipe_list.include? 'yard'
  
  say_recipe 'yard'
  
  gem 'yard', :group => [:development, :test] 
  gem 'yardstick', :group => [:development, :test]
  
  run 'rm -rf /doc/'
  say_wizard "generating a .yardopts file for yardoc configuration"
  file '.yardopts',<<-RUBY
## --use-cache
--title #{app_name}
app/**/*.rb 
config/routes.rb 
lib/**/*.rb 
README.textile
spec/
--exclude README.md --exclude LICENSE
RUBY

  after_bundler do
    
    run 'yardoc'
    
    if extra_recipes.include? 'git'
      git :tag => "yard_installation"
      git :add => '.'
      git :commit => "-am 'Installed Yard as an alternative to RDoc.'"
    end
    
  end
  
end
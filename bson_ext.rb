# >--------------------------------[ bson_ext ]--------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/bson_ext.rb

if recipe_list.include? 'mongoid'
  
  # Add bson_ext gem for use with Mongoid
  say_recipe 'bson_ext'

  gem 'bson_ext', '>= 1.2.4'
  
end



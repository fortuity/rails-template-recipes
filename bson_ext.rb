# >--------------------------------[ bson_ext ]--------------------------------<

if recipe_list.include? 'mongoid'
  
  # Add bson_ext gem for use with Mongoid
  say_recipe 'bson_ext'

  gem 'bson_ext'
  
end



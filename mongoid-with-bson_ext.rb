# >--------------------------------[ Mongoid with bson_ext ]--------------------------------<

# Utilize MongoDB with Mongoid as the ORM.
say_recipe 'Mongoid with bson_ext'

gem 'mongoid', '>= 2.0.0.rc.7'
gem 'bson_ext', '1.2.2'

after_bundler do
  generate 'mongoid:config'
end

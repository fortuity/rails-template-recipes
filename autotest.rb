say_recipe 'autotest'

gem 'autotest', :group => :test
gem 'autotest-growl', :group => :test

# if rails project is being generated from a mac, then add a mac bundler group
# and exclude the group when bundler'ing on other platforms
if RUBY_PLATFORM =~ /darwin/
  gem 'autotest-fsevent', :group => :mac
end


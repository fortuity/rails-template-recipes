# >-------------------------------[ Cucumber ]--------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/cucumber.rb

# This recipe replaces the RailsWizard standard Cucumber recipe and adds extras.

if extra_recipes.include? 'cucumber'
  
  # Use Cucumber for integration testing with Capybara.
  say_recipe 'Cucumber'

  gem 'cucumber-rails', :group => :test
  gem 'capybara', :group => :test

  after_bundler do
    generate "cucumber:install --capybara#{' --rspec' if extra_recipes.include?('rspec')}#{' -D' unless recipe_list.include?('activerecord')}"

    # reset your application database to a pristine state during testing
    create_file 'features/support/local_env.rb' do 
    <<-RUBY
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.orm = "mongoid"
Before { DatabaseCleaner.clean }
RUBY
    end
  
    if extra_recipes.include? 'git'
      git :tag => "cucumber_installation"
      git :add => '.'
      git :commit => "-am 'Installed Cucumber.'"
    end

  end

end
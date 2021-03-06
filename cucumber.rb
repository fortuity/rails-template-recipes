# >-------------------------------[ Cucumber ]--------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/cucumber.rb

# This recipe replaces the RailsWizard standard Cucumber recipe and adds extras.

if extra_recipes.include? 'cucumber'
  
  #----------------------------------------------------------------------------
  # Use Cucumber for BDD. Include Capybara.
  #----------------------------------------------------------------------------

  say_recipe 'Cucumber'

  gem 'cucumber-rails', ">= 0.4.0", :group => :test
  gem 'capybara', ">= 0.4.1.2", :group => :test
  gem 'relish', ">= 0.2.2", :group => :development

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

    # see https://github.com/aslakhellesoy/cucumber-rails/issues/closed/#issue/77
    gsub_file 'features/support/env.rb', /require 'cucumber\/rails\/capybara_javascript_emulation'/, "# require 'cucumber/rails/capybara_javascript_emulation'"

    if extra_recipes.include? 'git'
      git :tag => "cucumber_installation"
      git :add => '.'
      git :commit => "-am 'Installed Cucumber.'"
    end

  end

  #----------------------------------------------------------------------------
  # Add Cucumber scenarios for Devise
  #----------------------------------------------------------------------------

  if extra_recipes.include? 'devise'

    say_recipe 'Cucumber Scenarios'

    after_bundler do

      # copy all the Cucumber scenario files from the rails3-mongoid-devise example app
      inside 'features/users' do
        get 'https://github.com/fortuity/rails3-mongoid-devise/raw/master/features/users/sign_in.feature', 'sign_in.feature'
        get 'https://github.com/fortuity/rails3-mongoid-devise/raw/master/features/users/sign_out.feature', 'sign_out.feature'
        get 'https://github.com/fortuity/rails3-mongoid-devise/raw/master/features/users/sign_up.feature', 'sign_up.feature'
        get 'https://github.com/fortuity/rails3-mongoid-devise/raw/master/features/users/user_edit.feature', 'user_edit.feature'
        get 'https://github.com/fortuity/rails3-mongoid-devise/raw/master/features/users/user_show.feature', 'user_show.feature'
      end
      inside 'features/step_definitions' do
        get 'https://github.com/fortuity/rails3-mongoid-devise/raw/master/features/step_definitions/user_steps.rb', 'user_steps.rb'
      end
      remove_file 'features/support/paths.rb'
      inside 'features/support' do
        get 'https://github.com/fortuity/rails3-mongoid-devise/raw/master/features/support/paths.rb', 'paths.rb'
      end

      if extra_recipes.include? 'git'
        git :tag => 'cucumber_scenarios'
        git :add => '.'
        git :commit => "-am 'Installed Cucumber Scenarios for Devise.'"
      end

    end

  end

end
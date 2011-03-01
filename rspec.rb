# >---------------------------------[ RSpec ]---------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/rspec.rb

# This recipe replaces the RailsWizard standard RSpec recipe and adds extras.

if extra_recipes.include? 'rspec'

  # Use RSpec instead of TestUnit
  say_recipe 'RSpec'

  gem 'rspec-rails', '>= 2.5', :group => [:development, :test]
  gem 'database_cleaner', :group => :test

  # note: there is no need to specify the RSpec generator in the config/application.rb file

  after_bundler do

    generate 'rspec:install'

    # remove ActiveRecord artifacts
    gsub_file 'spec/spec_helper.rb', /config.fixture_path/, '# config.fixture_path'
    gsub_file 'spec/spec_helper.rb', /config.use_transactional_fixtures/, '# config.use_transactional_fixtures'

    # reset your application database to a pristine state during testing
    inject_into_file 'spec/spec_helper.rb', :before => "\nend" do
    <<-RUBY
  \n
  # Clean up the database
  require 'database_cleaner'
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongoid"
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end
RUBY
    end

    # remove either possible occurrence of "require rails/test_unit/railtie"
    gsub_file 'config/application.rb', /require 'rails\/test_unit\/railtie'/, "# require 'rails/test_unit/railtie'"
    gsub_file 'config/application.rb', /require "rails\/test_unit\/railtie"/, "# require 'rails/test_unit/railtie'"
    
    say_wizard "Removing test folder (not needed for RSpec)"
    run 'rm -rf test/'

    if extra_recipes.include? 'git'
      git :tag => "rspec_installation"
      git :add => '.'
      git :commit => "-am 'Installed RSpec.'"
    end

  end

end
# >---------------------------------[ RSpec ]---------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/rspec.rb

# This recipe replaces the RailsWizard standard RSpec recipe and adds extras.

if extra_recipes.include? 'rspec'

  # Use RSpec instead of TestUnit
  say_recipe 'RSpec'

  gem 'rspec-rails', '>= 2.5', :group => [:development, :test]
  gem 'database_cleaner', :group => :test
  gem 'factory_girl_rails', ">= 1.1.beta1", :group => :test

  if extra_recipes.include? 'mongoid'
    # include RSpec matchers from the mongoid-rspec gem
    gem 'mongoid-rspec', ">= 1.4.1", :group => :test
  end
  
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

    if extra_recipes.include? 'mongoid'
      # configure RSpec to use matchers from the mongoid-rspec gem
      create_file 'spec/support/mongoid.rb' do 
      <<-RUBY
RSpec.configure do |config|
  config.include Mongoid::Matchers
end
RUBY
      end
    end

    if extra_recipes.include? 'devise'
      # add Devise test helpers
      create_file 'spec/support/devise.rb' do 
      <<-RUBY
RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end
RUBY
      end
    end

    if extra_recipes.include? 'git'
      git :tag => "rspec_installation"
      git :add => '.'
      git :commit => "-am 'Installed RSpec.'"
    end

  end

end
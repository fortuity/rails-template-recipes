say_recipe "Capistrano (lastmile)"

gem 'capistrano',           :group => :development
gem 'capistrano-ext',       :group => :development, :require => nil
gem 'capistrano-lastmile',  :group => :development, :require => nil,
  :git => "git://github.com/fnichol/capistrano-lastmile.git"
gem 'ffi-ncurses',          :group => :development, :platforms => :jruby

after_bundler do
  file 'Capfile', <<-CAPFILE.gsub(/^ {4}/, '')
    require "rubygems"
    require "bundler/setup"

    # override default staging environments set by capistrano-lastmile
    #set :stages,          %w{uat testing staging production}
    # override default stage set by capistrano-lastmile
    #set :default_stage,   "uat"

    # enable default-disabled recipes
    #set :use_config_yaml, true
    #set :use_whenever,    true

    require "capistrano/lastmile"
  CAPFILE

  file 'config/deploy.rb', <<-DEPLOY.gsub(/^ {4}/, '')
    # general deployment configuration
    # please put specific deployment config in config/deploy/*.rb

    set :application, "#{app_name}"

    set :repository,  "git://github.com/"
  DEPLOY

  file 'config/deploy/staging.rb', <<-STAGING.gsub(/^ {4}/, '')
    # STAGING-specific deployment configuration
    # please put general deployment config in config/deploy.rb

    set :db_username,   "#{app_name[0,11]}_stg"

    set :deploy_server, "vagrant"
  STAGING

  file 'config/deploy/production.rb', <<-PRODUCTION.gsub(/^ {4}/, '')
    # PRODUCTION-specific deployment configuration
    # please put general deployment config in config/deploy.rb

    set :db_username,   "#{app_name[0,11]}_prd"

    set :deploy_server, "prd.example.com"
  PRODUCTION
end

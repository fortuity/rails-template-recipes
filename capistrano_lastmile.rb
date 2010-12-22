say_recipe "Capistrano (lastmile)"

gem 'capistrano',           :group => :development
gem 'capistrano-ext',       :group => :development, :require => nil
gem 'capistrano-lastmile',  :group => :development, :require => nil,
  :git => "git://github.com/fnichol/capistrano-lastmile.git"

after_bundler do
  file 'Capfile', <<-CAPFILE.gsub(/^ {4}/, '')
    require "rubygems"
    require "bundler/setup"

    require "capistrano/lastmile"
  CAPFILE

  file 'config/deploy.rb', <<-DEPLOY.gsub(/^ {4}/, '')
    set :application, "#{app_name}"

    set :repository,  "git://github.com/"
  DEPLOY

  file 'config/deploy/staging.rb', <<-STAGING.gsub(/^ {4}/, '')
    set :db_username,   "#{app_name[0,11]}_stg"

    set :deploy_server, "vagrant"
  STAGING

  file 'config/deploy/production.rb', <<-PRODUCTION.gsub(/^ {4}/, '')
    set :db_username,   "#{app_name[0,11]}_prd"

    set :deploy_server, "prd.example.com"
  PRODUCTION
end

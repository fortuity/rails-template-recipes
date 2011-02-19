# >--------------------------------[ action_mailer ]--------------------------------<

say_recipe 'ActionMailer configuration'

# modifying environment configuration files for ActiveRecord
gsub_file 'config/environments/development.rb', /# Don't care if the mailer can't send/, '# ActionMailer Config'
gsub_file 'config/environments/development.rb', /config.action_mailer.raise_delivery_errors = false/ do
<<-RUBY
config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  # A dummy setup for development - no deliveries, but logged
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default :charset => "utf-8"
RUBY
end
gsub_file 'config/environments/production.rb', /config.active_support.deprecation = :notify/ do
<<-RUBY
config.active_support.deprecation = :notify

  config.action_mailer.default_url_options = { :host => 'yourhost.com' }
  # ActionMailer Config
  # Setup for production - deliveries, no errors raised
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default :charset => "utf-8"
RUBY
end

if extra_recipes.include? 'git'
  say_wizard "commiting changes to git"
  git :add => '.'
  git :commit => "-am 'Set ActionMailer configuration.'"
end

# >--------------------------------[ jquery_fix ]--------------------------------<

say_recipe 'jQuery Fix'

after_bundler do
  # see https://github.com/intridea/rails_wizard/issues#issue/27
  # the standard RailsWizard jQuery recipe has an error that must be fixed with this:
  gsub_file "config/application.rb", /config.action_view.javascript_expansions[:defaults] = %w()\n/, ""
end

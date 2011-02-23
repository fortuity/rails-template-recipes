# >--------------------------------[ jquery_fix ]--------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/jquery_fix.rb

say_recipe 'jQuery Fix'

# see https://github.com/intridea/rails_wizard/issues#issue/27
# the standard RailsWizard jQuery recipe has an error that must be fixed with this:
gsub_file "config/application.rb", /        config.action_view.javascript_expansions\[:defaults\] = \%w\(\)\n/, ""


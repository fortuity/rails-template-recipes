# >--------------------------------[ jQuery ]---------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/jquery.rb

# This recipe replaces the RailsWizard standard jQuery recipe which has an error as of 18 Feb 2011:
# https://github.com/intridea/rails_wizard/issues#issue/27

# Utilize the jQuery Javascript framework instead of Protoype.

if extra_recipes.include? 'jquery'
  
  # Adds the latest jQuery and Rails UJS helpers for jQuery.
  say_recipe 'jQuery'

  # remove the Prototype adapter file
  remove_file 'public/javascripts/rails.js'
  # add jQuery files
  inside "public/javascripts" do
    get "https://github.com/rails/jquery-ujs/raw/master/src/rails.js", "rails.js"
    get "http://code.jquery.com/jquery-1.5.min.js", "jquery.js"
  end
  # adjust the Javascript defaults
  inject_into_file 'config/application.rb', "config.action_view.javascript_expansions[:defaults] = %w(jquery rails)\n", :after => "config.action_view.javascript_expansions[:defaults] = %w()\n", :verbose => false
  gsub_file "config/application.rb", /config.action_view.javascript_expansions\[:defaults\] = \%w\(\)\n/, ""
  
  if extra_recipes.include? 'git'
    git :tag => "jquery_installation"
    git :add => '.'
    git :commit => "-am 'jQuery installation.'"
  end
  
end


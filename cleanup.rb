# >--------------------------------[ cleanup ]--------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/cleanup.rb

say_recipe 'cleanup'

# remove unnecessary files
%w{
  README
  doc/README_FOR_APP
  public/index.html
  public/images/rails.png
}.each { |file| remove_file file }

# add placeholder READMEs
get "https://github.com/fortuity/rails-template-recipes/raw/master/sample_readme.txt", "README"
get "https://github.com/fortuity/rails-template-recipes/raw/master/sample_readme.textile", "README.textile"
gsub_file "README", /App_Name/, "#{app_name.humanize.titleize}"
gsub_file "README.textile", /App_Name/, "#{app_name.humanize.titleize}"

# remove commented lines from Gemfile
# thanks to https://github.com/perfectline/template-bucket/blob/master/cleanup.rb
gsub_file "Gemfile", /#.*\n/, "\n"
gsub_file "Gemfile", /\n+/, "\n"

if extra_recipes.include? 'git'
  say_wizard "commiting deletes of unneeded files to git"
  git :add => '.'
  git :commit => "-am 'Removed unnecessary files left over from initial app generation.'"
end

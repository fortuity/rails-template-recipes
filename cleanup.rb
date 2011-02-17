# >--------------------------------[ cleanup ]--------------------------------<

say_recipe 'cleanup'

# remove unnecessary files
%w{
  README
  doc/README_FOR_APP
  public/index.html
  public/favicon.ico
  public/images/rails.png
}.each { |file| remove_file file }

# remove commented lines from Gemfile
# thanks to https://github.com/perfectline/template-bucket/blob/master/cleanup.rb
gsub_file "Gemfile", /#.*\n/, "\n"
gsub_file "Gemfile", /\n+/, "\n"

if extra_recipes.include? 'git'
  say_wizard "commiting deletes of unneeded files to git"
  git :add => '.'
  git :commit => "-am 'Removed unnecessary files left over from initial app generation.'"
end

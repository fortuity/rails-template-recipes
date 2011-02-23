# >--------------------------------[ ban_spiders ]--------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/ban_spiders.rb

say_recipe 'ban spiders'

# ban spiders from your site by changing robots.txt
say_wizard "banning spiders from your site by changing robots.txt"
gsub_file 'public/robots.txt', /# User-Agent/, 'User-Agent'
gsub_file 'public/robots.txt', /# Disallow/, 'Disallow'

if extra_recipes.include? 'git'
  say_wizard "commiting changes to git"
  git :add => '.'
  git :commit => "-am 'Ban spiders from the site by changing robots.txt'"
end

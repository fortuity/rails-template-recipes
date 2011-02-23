# >--------------------------------[ heroku ]--------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/heroku.rb

say_recipe 'Heroku'

# Add a Heroku gem to the Gemfile
gem 'heroku', :group => :development

# Add a Heroku ignore file
file ".slugignore", <<-EOS.gsub(/^  /, '')
  *.psd
  *.pdf
  test
  spec
  features
  doc
  docs
EOS

if extra_recipes.include? 'git'
  say_wizard "commiting changes to git"
  git :add => '.'
  git :commit => "-am 'Add a Heroku gem and slugignore file.'"
end

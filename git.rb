# >--------------------------------[ Git ]---------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/git.rb

# Set up Git for version control
say_recipe 'Git'

# Git should ignore some files
remove_file '.gitignore'
get "https://github.com/fortuity/rails-template-recipes/raw/master/gitignore.txt", ".gitignore"

# Initialize new Git repo
git :init
git :add => '.'
git :commit => "-aqm 'Initial commit of new Rails app'"

say_wizard "Creating a git working_branch (to follow the stream of development)."
git :checkout => ' -b working_branch'
git :add => '.'
git :commit => "-m 'Initial commit of working_branch (to establish a clean base line).'"

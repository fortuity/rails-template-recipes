# >--------------------------------[ Git ]---------------------------------<

# Set up Git for version control
say_recipe 'Git'

# Git should ignore some files
remove_file '.gitignore'
file '.gitignore', <<-'IGNORES'.gsub(/^ {2}/, '')
  # bundler state
  /.bundle
  /vendor/bundle/

  # minimal Rails specific artifacts
  db/*.sqlite3
  /log/*
  tmp/*

  # various artifacts
  **.war
  *.rbc
  *.sassc
  .rspec
  .sass-cache
  /config/config.yml
  /config/database.yml
  /coverage.data
  /coverage/
  /db/*.javadb/
  /db/*.sqlite3-journal
  /doc/api/
  /doc/app/
  /doc/features.html
  /doc/specs.html
  /log/*
  /public/cache
  /public/stylesheets/compiled
  /public/system
  /spec/tmp/*
  /tmp/*
  /cache
  /capybara*
  /capybara-*.html
  /gems
  /rerun.txt
  /spec/requests
  /spec/routing
  /spec/views
  /specifications

  # scm revert files
  **.orig

  # mac finder poop
  .DS_Store

  # netbeans project directory
  /nbproject/

  # textmate project files
  /*.tmpproj

  # vim poop
  **.swp
IGNORES

# Initialize new Git repo
git :init
git :add => '.'
git :commit => "-aqm 'Initial commit of new Rails app'"

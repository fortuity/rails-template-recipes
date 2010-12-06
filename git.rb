say_recipe 'git'

remove_file '.gitignore'
file '.gitignore', <<-'IGNORES'.gsub(/^ {2}/, '')
  # bundler state
  /.bundle
  /vendor/bundle/
 
  # rails specific artifacts
  /log/
  /tmp/
  /doc/api/
  /doc/app/
  /config/database.yml
  /config/config.yml
  /db/*.sqlite3
  /db/*.sqlite3-journal
  /db/*.javadb/
  /derby.log
  **.war
  /coverage/
  /coverage.data
  /public/system/
  rerun.txt
  capybara-*.html

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

git :init


say_recipe 'ActiveRecord extras'

gem 'mysql',
  :group => :production, :platforms => :ruby
gem 'activerecord-jdbcmysql-adapter',
  :group => :production, :platforms => :jruby, :require => false

gem 'sqlite3-ruby',
  :group => [:development, :test], :platforms => :ruby
gem 'activerecord-jdbcsqlite3-adapter',
  :group => [:development, :test], :platforms => :jruby, :require => false

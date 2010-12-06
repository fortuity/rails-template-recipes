say_recipe 'autotest'

gem 'autotest', :group => :test
gem 'autotest-growl', :group => :test

# if rails project is being generated from a mac, then add a mac bundler group
# and exclude the group when bundler'ing on other platforms
if RUBY_PLATFORM =~ /darwin/
  gem 'autotest-fsevent', :group => :mac
end

after_bundler do
  create_file '.autotest' do
    <<-'AUTOTEST'.gsub(/^ {6}/, '')
      require 'autotest/growl'
      if RUBY_PLATFORM =~ /-darwin/
        begin
          require 'autotest/fsevent'
        rescue LoadError
          puts "== autotest-fsevent gem will improve performance on Mac OS X"
          puts "== to use, just: gem install autotest-fsevent"
        end
      end
       
      Autotest.add_hook :initialize do |autotest|
        %w{.git .svn .hg .DS_Store ._* vendor tmp log doc}.each do |exception|
          autotest.add_exception(exception)
        end
      end
    AUTOTEST
  end
end


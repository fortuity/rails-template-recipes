say_recipe 'autotest'

gem 'autotest', :group => :test
gem 'autotest-growl', :group => :test

# if rails project is being generated from a mac, then add a mac bundler group
# and exclude the group when bundler'ing on other platforms
if RUBY_PLATFORM =~ /darwin/
  gem 'autotest-fsevent', :group => :mac
end

create_file 'lib/tasks/auto.rake' do
  <<-'RAKE'.gsub(/^ {4}/, '')
    namespace :auto do
      desc 'Runs autotest on cucumber and rspec tests'
      task :test do
        gem 'test-unit', '1.2.3' if RUBY_VERSION.to_f >= 1.9
        ENV['RSPEC'] = 'true'       # allows autotest to discover rspec
        ENV['AUTOTEST'] = 'true'    # allows autotest to run w/ color on linux
        ENV['AUTOFEATURE'] = 'true' # allows autotest to discover cucumber
        system((RUBY_PLATFORM =~ /mswin|mingw/ ? 'autotest.bat' : 'autotest'), *ARGV) ||
          $stderr.puts("Unable to find autotest.  Please install ZenTest or fix your PATH")
      end

      desc 'Runs autotest on only rspec tests'
      task :spec do
        gem 'test-unit', '1.2.3' if RUBY_VERSION.to_f >= 1.9
        ENV['RSPEC'] = 'true'       # allows autotest to discover rspec
        ENV['AUTOTEST'] = 'true'    # allows autotest to run w/ color on linux
        ENV['AUTOFEATURE'] = 'false' # allows autotest to discover cucumber
        system((RUBY_PLATFORM =~ /mswin|mingw/ ? 'autotest.bat' : 'autotest'), *ARGV) ||
          $stderr.puts("Unable to find autotest.  Please install ZenTest or fix your PATH")
      end

      desc 'Runs autotest on only cucumber tests'
      task :cucumber do
        gem 'test-unit', '1.2.3' if RUBY_VERSION.to_f >= 1.9
        ENV['RSPEC'] = 'false'       # allows autotest to discover rspec
        ENV['AUTOTEST'] = 'true'    # allows autotest to run w/ color on linux
        ENV['AUTOFEATURE'] = 'true' # allows autotest to discover cucumber
        system((RUBY_PLATFORM =~ /mswin|mingw/ ? 'autotest.bat' : 'autotest'), *ARGV) ||
          $stderr.puts("Unable to find autotest.  Please install ZenTest or fix your PATH")
      end

      desc 'Alias for auto:test'
      task :all => 'auto:test'
    end

    desc 'Autotest'
    task :auto => 'auto:test'
  RAKE
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


say_recipe 'rvm'

# load in RVM environment
if ENV['MY_RUBY_HOME'] && ENV['MY_RUBY_HOME'].include?('rvm')
  begin
    rvm_path     = File.dirname(File.dirname(ENV['MY_RUBY_HOME']))
    rvm_lib_path = File.join(rvm_path, 'lib')
    $LOAD_PATH.unshift rvm_lib_path

    require 'rvm'
  rescue LoadError
    # RVM is unavailable at this point.
    raise "RVM ruby lib is currently unavailable."
  end
else
  raise "RVM ruby lib is currently unavailable."
end

rvm_env = "default@#{app_name}"

# create rvmrc file
create_file '.rvmrc' do
  "rvm #{rvm_env}"
end

say_wizard "Creating RVM gemset #{app_name}..."
RVM.gemset_create app_name

# trust the rvmrc
run "echo rvm rvmrc trust #{File.dirname(File.expand_path(app_path))}"

say_wizard "Switching to use RVM gemset #{app_name}"
RVM.gemset_use! app_name

if run("gem list --installed bundler", :capture => true) =~ /false/
  run "gem install bundler --no-rdoc --no-ri"
end

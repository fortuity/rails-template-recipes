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

# trust the rvmrc
run "rvm rvmrc trust #{File.expand_path(app_path)}"

# create and switch into gemset
RVM.gemset_create app_name
RVM.gemset_use! app_name

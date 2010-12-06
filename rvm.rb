say_recipe 'rvm'

rvm_env = "default@#{@app_name}"

# create rvmrc
file '.rvmrc' "rvm #{rvm_env}"

# trust the rvmrc
run "rvm rvmrc trust #{@app_path}"

# switch into the ruby/gemset
run "rvm use #{rvm_env}"


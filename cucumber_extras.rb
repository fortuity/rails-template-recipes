say_recipe 'Cucumber extras'

# pop a browser window in cucumber and other tasks
gem 'launchy', :env => :test

gem 'database_cleaner', :env => :test

after_bundler do
  # Add autotest runner erb opts
  gsub_file "config/cucumber.yml", /^(std_opts = .*wip")$/, '\1' << <<-'OPTS'.gsub(/^ {4}/, '')

    std_opts += " --tags ~@proposed --color"
    autotest_opts = "--format pretty --strict --tags ~@proposed --color"
    autotest_all_opts = "--format #{ENV['CUCUMBER_FORMAT'] || 'progress'} --strict --tags ~@proposed --color #{ENV['CUCUMBER_EXCLUDE']}"
  OPTS

  # Add autotest runner formats
  gsub_file "config/cucumber.yml", /^(rerun: .* ~@wip)$/, '\1 --tags ~@proposed' 
  append_to_file "config/cucumber.yml" do
    <<-'YAML'.gsub(/^ {6}/, '')
      autotest: <%= autotest_opts %> features
      autotest-all: <%= autotest_all_opts %> features
    YAML
  end
end


say_recipe 'Cucumber extras'

after_bundler do
  # Add autotest runner erb opts
  inject_into_file "config/cucumber.yml", :before => '%>\n' do
    <<-'OPTS'.gsub(/^ {6}/, '')
      std_opts += "--tags ~@proposed --color"
      autotest_opts = "--format pretty --strict --tags ~@proposed --color"
      autotest_all_opts = "--format #{ENV['CUCUMBER_FORMAT'] || 'progress'} --strict --tags ~@proposed --color #{ENV['CUCUMBER_EXCLUDE']}"
    OPTS
  end

  # Add autotest runner formats
  gsub_file "config/cucumber.yml", /^(rerun: .* ~@wip)$/, '\1 --tags ~@proposed' 
  append_to_file "config/cucumber.yml" do
    <<-'YAML'.gsub(/^ {6}/, '')
      autotest: <%= autotest_opts %> features
      autotest-all: <%= autotest_all_opts %> features
    YAML
  end
end


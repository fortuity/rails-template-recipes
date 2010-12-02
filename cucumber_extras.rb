say_recipe 'Cucumber extras'

after_bundler do
  # Add autotest runner erb opts
  gsub_file "config/cucumber.yml", /^(std_opts = .* ~@wip)"$/, '\1 ' <<-'OPTS'.gsub(/^ {4}/, '')
    --tags ~@proposed --color"
    autotest_opts = "--format pretty --strict --tags ~@proposed --color"
    autotest_all_opts = "--format #{ENV['CUCUMBER_FORMAT'] || 'progress'} --strict --tags ~@proposed --color #{ENV['CUCUMBER_EXCLUDE']}"
  OPTS

  # Add autotest runner formats
  gsub_file "config/cucumber.yml", /^(rerun: .* ~@wip)$"$/, '\1 ' <<-'YAML'.gsub(/^ {4}/, '')
    --tags ~@proposed
    autotest: <%= autotest_opts %> features
    autotest-all: <%= autotest_all_opts %> features
  YAML
end


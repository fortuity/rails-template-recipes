say_recipe 'RSpec extras'

after_bundler do
  # customize default formatting
  append_to_file ".rspec" do
    <<-'RSPEC'.gsub(/^ {6}/, '')
      --format progress
    RSPEC
  end
end


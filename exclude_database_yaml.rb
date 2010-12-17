say_recipe 'Exclude database.yml from version control'

create_file 'lib/tasks/init_database_yaml.rake' do
  <<-'RAKE'.gsub(/^ {4}/, '')
    namespace :init do
      task 'database_yaml' do
        unless File.exists?(File.join('config', 'database.yml'))
          cp(File.join('config', 'database.sample.yml'), 
             File.join('config', 'database.yml'), :verbose => true)
        end
      end
    end

    unless Rake::Task.task_defined?("init")
      desc "Initializes the rails environment for development"
      task :init do ; end
    end

    # Add namespaced tasks to default :init task
    Rake::Task["init"].enhance ["init:database_yaml"]
  RAKE
end

# wait until all generators have had a chance to touch config/database.yml
after_bundler do
  say_wizard "Adding Java platform detection in database.yml"
  gsub_file "config/database.yml", /^(\s*adapter:) (.+)$/,
    %q{\1 <%= RUBY_PLATFORM =~ /java/ ? '\2' : '\2' %>}

  say_wizard "Creating config/database.sample.yml for version control"
  FileUtils.cp "config/database.yml", "config/database.sample.yml"
end

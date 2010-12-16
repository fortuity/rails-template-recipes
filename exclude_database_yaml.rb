say_recipe 'Exclude database.yml from version control'

copy_file "config/database.yml", "config/database.sample.yml"
remove_file "config/database.yml"

create_file 'lib/tasks/init_database_yaml.rake' do
  <<-'RAKE'.gsub(/^ {6}/, '')
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
    Rake::Task["init"].enhance { Rake::Task["init:database_yaml"].invoke }
  RAKE
end

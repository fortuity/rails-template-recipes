say_recipe 'Create rake init:* tasks'

create_file 'lib/tasks/init.rake' do
  <<-'RAKE'.gsub(/^ {4}/, '')
    unless Rake::Task.task_defined?("init")
      desc "Initializes the rails environment for development"
      task :init do ; end
    end

    # Add namespaced tasks to default :init task
    db_tasks = %w{ tmp:create db:schema:dump db:setup }
    Rake::Task["init"].enhance do
      db_tasks.each { |t| Rake::Task[t].invoke }
    end
  RAKE
end


# Rails Wizard Config

Select the recipes you would like to include and add some like the following to the
*Customize Template* section at <http://railswizard.org/>:

    git_repo = "https://github.com/fnichol/rails-template-recipes"
    extra_recipes = %w{ rvm git cleanup activerecord_extras
      cucumber_extras rspec_extras autotest irb application.haml
      flashes_partial.haml flashes_partial.erb
      exclude_database_yaml rake_init_tasks capistrano_lastmile }
    extra_recipes.each { |r| apply "#{git_repo}/raw/master/#{r}.rb" }


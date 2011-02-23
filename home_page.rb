# >--------------------------------[ home_page ]--------------------------------<

# There is Haml code in this script. Changing the indentation is perilous between HAMLs.

say_recipe 'Home Page'

after_bundler do
  
  # remove the default home page
  remove_file 'public/index.html'
  
  # create a home controller and view
  generate(:controller, "home index")

  # set up a simple home page (with placeholder content)
  if recipe_list.include? 'haml'
    remove_file 'app/views/home/index.html.haml'
    # we have to use single-quote-style-heredoc to avoid interpolation
    create_file 'app/views/home/index.html.haml' do 
    <<-'HAML'
%h3 Home
HAML
    end
  else
    remove_file 'app/views/home/index.html.erb'
    create_file 'app/views/home/index.html.erb' do <<-ERB
<h3>Home</h3>
ERB
    end
  end

  # set routes
  gsub_file 'config/routes.rb', /get \"home\/index\"/, 'root :to => "home#index"'

  if extra_recipes.include? 'git'
    say_wizard "commiting changes to git"
    git :add => '.'
    git :commit => "-am 'Create a home controller and view.'"
  end

end
# >--------------------------------[ home_page ]--------------------------------<

say_recipe 'Home Page'

# create a home controller and view
generate(:controller, "home index")
gsub_file 'config/routes.rb', /get \"home\/index\"/, 'root :to => "home#index"'

if recipe_list.include? 'devise' || extra_recipes.include? 'devise_extras'
  
  # set up a simple demonstration of Devise (displaying a list of users)
  gsub_file 'app/controllers/home_controller.rb', /def index/ do
  <<-RUBY
  def index
      @users = User.all
  RUBY
  end

  if recipe_list.include? 'haml'
    run 'rm app/views/home/index.html.haml'
    # we have to use single-quote-style-heredoc to avoid interpolation
    create_file 'app/views/home/index.html.haml' do 
  <<-'FILE'
  - @users.each do |user|
    %p User: #{link_to user.name, user}
  FILE
    end
  else
    append_file 'app/views/home/index.html.erb' do <<-FILE
  <% @users.each do |user| %>
    <p>User: <%=link_to user.name, user %></p>
  <% end %>
    FILE
    end
  end
  
end

if extra_recipes.include? 'git'
  say_wizard "commiting changes to git"
  git :add => '.'
  git :commit => "-am 'Create a home controller and view.'"
end

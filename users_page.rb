# >--------------------------------[ users_page ]--------------------------------<

# There is Haml code in this script. Changing the indentation is perilous between HAMLs.

say_recipe 'Users Page'

after_bundler do

  if extra_recipes.include? 'devise_extras'

    #----------------------------------------------------------------------------
    # Create a users controller
    #----------------------------------------------------------------------------
    generate(:controller, "users show")
    gsub_file 'app/controllers/users_controller.rb', /def show/ do
    <<-RUBY
before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
RUBY
    end

    #----------------------------------------------------------------------------
    # Modify the routes
    #----------------------------------------------------------------------------
    # @devise_for :users@ route must be placed above @resources :users, :only => :show@.
    gsub_file 'config/routes.rb', /get \"users\/show\"/, '#get \"users\/show\"'
    gsub_file 'config/routes.rb', /devise_for :users/ do
    <<-RUBY
devise_for :users
  resources :users, :only => :show
RUBY
    end

    #----------------------------------------------------------------------------
    # Create a users show page
    #----------------------------------------------------------------------------
    if recipe_list.include? 'haml'
      run 'rm app/views/users/show.html.haml'
      # we have to use single-quote-style-heredoc to avoid interpolation
      create_file 'app/views/users/show.html.haml' do <<-'HAML'
%p
  User: #{@user.name}
HAML
      end
    else
      append_file 'app/views/users/show.html.erb' do <<-ERB
<p>User: <%= @user.name %></p>
ERB
      end
    end

    #----------------------------------------------------------------------------
    # Create a home page containing links to user show pages
    # (clobbers code from the home_page_users recipe)
    #----------------------------------------------------------------------------
    # set up the controller
    run 'rm app/controllers/home_controller.rb'
    create_file 'app/controllers/home_controller.rb' do
    <<-RUBY
class HomeController < ApplicationController
  def index
    @users = User.all
  end
end
RUBY
    end

    # modify the home page
    if recipe_list.include? 'haml'
      run 'rm app/views/home/index.html.haml'
      # we have to use single-quote-style-heredoc to avoid interpolation
      create_file 'app/views/home/index.html.haml' do
      <<-'HAML'
%h3 Home
- @users.each do |user|
  %p User: #{link_to user.name, user}
HAML
      end
    else
      run 'rm app/views/home/index.html.erb'
      create_file 'app/views/home/index.html.erb' do <<-ERB
<h3>Home</h3>
<% @users.each do |user| %>
  <p>User: <%=link_to user.name, user %></p>
<% end %>
ERB
      end
    end

  end

  if extra_recipes.include? 'git'
    say_wizard "commiting changes to git"
    git :add => '.'
    git :commit => "-am 'Add a users controller and user show page with links from the home page.'"
  end

end
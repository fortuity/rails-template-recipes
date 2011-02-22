# >--------------------------------[ users_page ]--------------------------------<

# There is Haml code in this script. Changing the indentation is perilous between HAMLs.

say_recipe 'Users Page'

after_bundler do

  if extra_recipes.include? 'devise_extras'

    #----------------------------------------------------------------------------
    # Create a users controller
    #----------------------------------------------------------------------------
    generate(:controller, "users show")
    # @devise_for :users@ route must be placed above @resources :users, :only => :show@.
    gsub_file 'config/routes.rb', /get \"users\/show\"/, '#get \"users\/show\"'
    gsub_file 'config/routes.rb', /devise_for :users/ do
    <<-RUBY
devise_for :users
  resources :users, :only => :show
RUBY
    end

    gsub_file 'app/controllers/users_controller.rb', /def show/ do
<<-RUBY
before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
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
    # Add links on home page for user show page
    # (clobbers code from the home_page recipe)
    #----------------------------------------------------------------------------
    # this could add a duplicate line but so what? belts and suspenders
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
      <<-'HAML'
%h3 Home
- @users.each do |user|
  %p User: #{user.name}
HAML
      end
    else
      run 'rm app/views/home/index.html.erb'
      create_file 'app/views/home/index.html.erb' do <<-ERB
<h3>Home</h3>
<% @users.each do |user| %>
  <p>User: <%= user.name %></p>
<% end %>
ERB
      end
    end

    #----------------------------------------------------------------------------
    # Create navigation links for Devise
    #----------------------------------------------------------------------------
    if recipe_list.include? 'haml'
      create_file "app/views/devise/menu/_login_items.html.haml" do <<-'HAML'
- if user_signed_in?
  %li
    = link_to('Logout', destroy_user_session_path)
- else
  %li
    = link_to('Login', new_user_session_path)
HAML
      end
    else
      create_file "app/views/devise/menu/_login_items.html.erb" do <<-ERB
<% if user_signed_in? %>
  <li>
  <%= link_to('Logout', destroy_user_session_path) %>        
  </li>
<% else %>
  <li>
  <%= link_to('Login', new_user_session_path)  %>  
  </li>
<% end %>
ERB
      end
    end

    if recipe_list.include? 'haml'
      create_file "app/views/devise/menu/_registration_items.html.haml" do <<-'HAML'
- if user_signed_in?
  %li
    = link_to('Edit account', edit_user_registration_path)
- else
  %li
    = link_to('Sign up', new_user_registration_path)
HAML
      end
    else
      create_file "app/views/devise/menu/_registration_items.html.erb" do <<-ERB
<% if user_signed_in? %>
  <li>
  <%= link_to('Edit account', edit_user_registration_path) %>
  </li>
<% else %>
  <li>
  <%= link_to('Sign up', new_user_registration_path)  %>
  </li>
<% end %>
ERB
      end
    end

  end

  if extra_recipes.include? 'git'
    say_wizard "commiting changes to git"
    git :add => '.'
    git :commit => "-am 'Add a users controller, user show page, and navigation links.'"
  end

end
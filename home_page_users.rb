# >--------------------------------[ home_page_users ]--------------------------------<

# There is Haml code in this script. Changing the indentation is perilous between HAMLs.

say_recipe 'Home Page Showing Users'

after_bundler do

  if extra_recipes.include? 'devise_extras'

    #----------------------------------------------------------------------------
    # Modify the home controller
    #----------------------------------------------------------------------------
    gsub_file 'app/controllers/home_controller.rb', /def index/ do
    <<-RUBY
def index
  @users = User.all
RUBY
    end

    #----------------------------------------------------------------------------
    # Replace the home page
    #----------------------------------------------------------------------------
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
      append_file 'app/views/home/index.html.erb' do <<-ERB
<h3>Home</h3>
<% @users.each do |user| %>
  <p>User: <%= user.name %></p>
<% end %>
ERB
      end
    end

  end

  if extra_recipes.include? 'git'
    say_wizard "commiting changes to git"
    git :add => '.'
    git :commit => "-am 'Added display of users to the home page.'"
  end

end
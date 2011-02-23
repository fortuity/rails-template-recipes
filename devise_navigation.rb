# >--------------------------------[ devise_navigation ]--------------------------------<

# There is Haml code in this script. Changing the indentation is perilous between HAMLs.

say_recipe 'Devise Navigation'

after_bundler do

  if extra_recipes.include? 'devise_extras'

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

    #----------------------------------------------------------------------------
    # Add navigation links to the default application layout
    #----------------------------------------------------------------------------
    if recipe_list.include? 'haml'
      inject_into_file 'app/views/layouts/application.html.erb', :after => "%body\n" do <<-HAML
  %ul.hmenu
    = render 'devise/menu/registration_items'
    = render 'devise/menu/login_items'
HAML
      end
    else
      inject_into_file 'app/views/layouts/application.html.erb', :after => "<body>\n" do
  <<-ERB
  <ul class="hmenu">
    <%= render 'devise/menu/registration_items' %>
    <%= render 'devise/menu/login_items' %>
  </ul>
ERB
      end
    end

    if extra_recipes.include? 'git'
      say_wizard "commiting changes to git"
      git :add => '.'
      git :commit => "-am 'Add navigation links for Devise.'"
    end

  end

end
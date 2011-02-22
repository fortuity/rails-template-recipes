# >--------------------------------[ add_user_name ]--------------------------------<

# There is Haml code in this script. Changing the indentation is perilous between HAMLs.

say_recipe 'add_user_name'

if recipe_list.include? 'haml'
  # the following gems are required to generate Devise views for Haml
  gem 'hpricot', :group => :development
  gem 'ruby_parser', :group => :development
end

after_bundler do
   
  #----------------------------------------------------------------------------
  # Add a 'name' attribute to the User model
  #----------------------------------------------------------------------------
  if recipe_list.include? 'mongoid'
    gsub_file 'app/models/user.rb', /end/ do
    <<-RUBY
    field :name
    validates_presence_of :name
    validates_uniqueness_of :name, :email, :case_sensitive => false
    attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  end
RUBY
    end
  end

  #----------------------------------------------------------------------------
  # Generate Devise views
  #----------------------------------------------------------------------------
  run 'rails generate devise:views'

  #----------------------------------------------------------------------------
  # Modify Devise views to add 'name'
  #----------------------------------------------------------------------------
  if haml_flag
     inject_into_file "app/views/devise/registrations/edit.html.haml", :after => "= devise_error_messages!\n" do
  <<-HAML
  %p
    = f.label :name
    %br/
    = f.text_field :name
HAML
     end
  else
     inject_into_file "app/views/devise/registrations/edit.html.erb", :after => "<%= devise_error_messages! %>\n" do
  <<-ERB
  <p><%= f.label :name %><br />
  <%= f.text_field :name %></p>
ERB
     end
  end

  if haml_flag
     inject_into_file "app/views/devise/registrations/new.html.haml", :after => "= devise_error_messages!\n" do
  <<-HAML
  %p
    = f.label :name
    %br/
    = f.text_field :name
HAML
     end
  else
     inject_into_file "app/views/devise/registrations/new.html.erb", :after => "<%= devise_error_messages! %>\n" do
  <<-ERB
  <p><%= f.label :name %><br />
  <%= f.text_field :name %></p>
ERB
     end
  end

  if extra_recipes.include? 'git'
    say_wizard "commiting changes to git"
    git :add => '.'
    git :commit => "-am 'Add a name attribute to the User model and modify Devise views.'"
  end
end

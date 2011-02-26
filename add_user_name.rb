# >--------------------------------[ add_user_name ]--------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/add_user_name.rb

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
  elsif recipe_list.include? 'mongo_mapper'
    # Using MongoMapper? Create an issue, suggest some code, and I'll add it
  elsif recipe_list.include? 'active_record'
    gsub_file 'app/models/user.rb', /end/ do
  <<-RUBY
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
end
RUBY
    end
  else
    # Placeholder for some other ORM
  end

  if extra_recipes.include? 'devise'
    #----------------------------------------------------------------------------
    # Generate Devise views
    #----------------------------------------------------------------------------
    run 'rails generate devise:views'

    #----------------------------------------------------------------------------
    # Modify Devise views to add 'name'
    #----------------------------------------------------------------------------
    if recipe_list.include? 'haml'
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

    if recipe_list.include? 'haml'
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
  end

  if extra_recipes.include? 'git'
    say_wizard "commiting changes to git"
    git :add => '.'
    if extra_recipes.include? 'devise'
      git :commit => "-am 'Add a name attribute to the User model and modify Devise views.'"
    else
      git :commit => "-am 'Add a name attribute to the User model.'"
    end
  end

end

# >--------------------------------[ add_user_name ]--------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/add_user_name.rb

# There is Haml code in this script. Changing the indentation is perilous between HAMLs.

say_recipe 'add_user_name'

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

  if extra_recipes.include? 'git'
    git :tag => "add_user_name"
    git :add => '.'
    git :commit => "-am 'Add a name attribute to the User model.'"
  end

  if extra_recipes.include? 'devise'
    unless extra_recipes.include? 'haml'
      #----------------------------------------------------------------------------
      # Generate Devise views (unless you are using Haml)
      #----------------------------------------------------------------------------
      run 'rails generate devise:views'

      #----------------------------------------------------------------------------
      # Modify Devise views to add 'name'
      #----------------------------------------------------------------------------
      inject_into_file "app/views/devise/registrations/edit.html.erb", :after => "<%= devise_error_messages! %>\n" do
      <<-ERB
      <p><%= f.label :name %><br />
      <%= f.text_field :name %></p>
  ERB
      end

      inject_into_file "app/views/devise/registrations/new.html.erb", :after => "<%= devise_error_messages! %>\n" do
      <<-ERB
      <p><%= f.label :name %><br />
      <%= f.text_field :name %></p>
  ERB
      end

    else

      # copy Haml versions of modified Devise views
      inside 'app/views/devise/registrations' do
        get 'https://github.com/fortuity/rails3-application-templates/raw/master/files/rails3-mongoid-devise/app/views/devise/registrations/edit.html.haml', 'edit.html.haml'
        get 'https://github.com/fortuity/rails3-application-templates/raw/master/files/rails3-mongoid-devise/app/views/devise/registrations/new.html.haml', 'new.html.haml'
      end

    end
  end

    if extra_recipes.include? 'git'
      git :tag => "devise_views"
      git :add => '.'
      git :commit => "-am 'Generate and modify Devise views.'"
    end

  end

end

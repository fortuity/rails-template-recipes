# >--------------------------------[ add_user_name ]--------------------------------<

say_recipe 'add_user_name'

after_bundler do
  # adding a 'name' attribute to the User model
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

  if extra_recipes.include? 'git'
    say_wizard "commiting changes to git"
    git :add => '.'
    git :commit => "-am 'Add a name attribute to the User model.'"
  end
end

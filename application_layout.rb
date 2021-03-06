# >--------------------------------[ application_layout ]--------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/application_layout.rb

# There is Haml code in this script. Changing the indentation is perilous between HAMLs.

say_recipe 'Application Layout'

after_bundler do

  #----------------------------------------------------------------------------
  # Set up the default application layout
  #----------------------------------------------------------------------------
  if recipe_list.include? 'haml'
    remove_file 'app/views/layouts/application.html.erb'
    create_file 'app/views/layouts/application.html.haml' do <<-HAML
!!!
%html
  %head
    %title #{app_name}
    = stylesheet_link_tag :all
    = javascript_include_tag :defaults
    = csrf_meta_tag
  %body
    - flash.each do |name, msg|
      = content_tag :div, msg, :id => "flash_\#{name}" if msg.is_a?(String)
    = yield
HAML
    end
  else
    inject_into_file 'app/views/layouts/application.html.erb', :after => "<body>\n" do
  <<-ERB
  <%- flash.each do |name, msg| -%>
    <%= content_tag :div, msg, :id => "flash_\#{name}" if msg.is_a?(String) %>
  <%- end -%>
ERB
    end
  end

  if extra_recipes.include? 'git'
    git :tag => "app_layout"
    git :add => '.'
    git :commit => "-am 'Add application layout.'"
  end
  
end
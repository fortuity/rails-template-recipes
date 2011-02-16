if recipe_list.include? 'haml'
  say_recipe 'Application layout (Haml)'

  remove_file 'app/views/application.html.erb'

  create_file 'app/views/application.html.haml' do
    <<-FLASHES.gsub(/^ {6}/, '')
      !!! 5
      %html
        %head
          %title #{app_name}
          = stylesheet_link_tag :all
          = javascript_include_tag :defaults
          = csrf_meta_tag
        %body
          = yield
    FLASHES
  end
end

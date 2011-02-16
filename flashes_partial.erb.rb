if recipe_list.include? 'erb'
  say_recipe 'Flashes partial (ERb)'

  create_file 'app/views/shared/_flashes.html.erb' do
    <<-'FLASHES'.gsub(/^ {6}/, '')
      <div id="flash">
        <% flash.each do |key, value| -%>
          <div id="flash_<%= key %>"><%=h value %></div>
        <% end -%>
      </div>
    FLASHES
  end
end

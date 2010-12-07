say_recipe 'Flashes partial (ERb)'

create_file 'app/views/shared/_flashes.html.erb' do
  <<-'FLASHES'.gsub(/^ {4}/, '')
    <div id="flash">
      <% flash.each do |key, value| -%>
        <div id="flash_<%= key %>"><%=h value %></div>
      <% end -%>
    </div>
  FLASHES
end


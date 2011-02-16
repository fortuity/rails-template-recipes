if recipes.include? 'haml'
  say_recipe 'Flashes partial (Haml)'

  create_file 'app/views/shared/_flashes.html.haml' do
    <<-'FLASHES'.gsub(/^ {6}/, '')
      #flash
        - flash.each do |key, value|
          %div{ :id => "flash_#{key}" }
            =h value
    FLASHES
  end
end

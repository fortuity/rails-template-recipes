# >--------------------------------[ css_setup ]--------------------------------<

# Application template recipe. Check for a newer version here:
# https://github.com/fortuity/rails-template-recipes/blob/master/css_setup.rb

say_recipe 'CSS Setup'

after_bundler do

  #----------------------------------------------------------------------------
  # Add a stylesheet with styles for a horizontal menu and flash messages
  #----------------------------------------------------------------------------
  create_file 'public/stylesheets/application.css' do <<-CSS
ul.hmenu {
  list-style: none;	
  margin: 0 0 2em;
  padding: 0;
}
ul.hmenu li {
  display: inline;  
}
#flash_notice, #flash_alert {
  padding: 5px 8px;
  margin: 10px 0;
}
#flash_notice {
  background-color: #CFC;
  border: solid 1px #6C6;
}
#flash_alert {
  background-color: #FCC;
  border: solid 1px #C66;
}
CSS
  end

end
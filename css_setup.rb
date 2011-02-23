# >--------------------------------[ css_setup ]--------------------------------<

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
p.notice {
  color: green;
}
p.alert {
  color: red;  
}
CSS
  end

end
# >--------------------------------[ css_setup ]--------------------------------<

say_recipe 'CSS Setup'

after_bundler do

  #----------------------------------------------------------------------------
  # Add stylesheet
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
CSS
  end

end
# >--------------------------------[ Test of Conditional ]---------------------------------<

say_wizard "begin test"

if recipe_list.include? 'haml'
  say_wizard 'recipe list includes Haml'
end

if recipe_list.include? 'mongoid'
  
  say_wizard "#{recipe_list.inspect}"
  
  # template.each do |k,v|
  # 
  #   say_wizard "#{k} is #{v}"
  # 
  # end
else
  say_wizard "recipe_list doesn't include target"
end

say_wizard "test complete"

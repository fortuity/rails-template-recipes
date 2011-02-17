# >--------------------------------[ Test of Conditional ]---------------------------------<

say_wizard "begin test"

if recipe_list.include? 'haml'
  say_wizard 'recipe list includes Haml'
end

template.each do |k,v|

  say_wizard "#{k} is #{v}"

end

say_wizard "test complete"

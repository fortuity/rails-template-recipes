# >--------------------------------[ Test of Conditional ]---------------------------------<

say_wizard "begin test"

if recipe_list.include? 'haml'
  say_wizard 'recipe list includes Haml'
end

say_wizard "template['orm'] is #{template['orm']}"

say_wizard "test complete"

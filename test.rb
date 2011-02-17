# >--------------------------------[ Test of Conditional ]---------------------------------<

say_wizard "begin test"

if recipe_list.include? 'haml'
  say_wizard 'recipe list includes Haml'
end

if template
  template.each do |k,v|

    say_wizard "#{k} is #{v}"

  end
else
  say_wizard "template is nil"
end

say_wizard "test complete"

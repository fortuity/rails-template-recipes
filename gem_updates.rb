# >--------------------------------[ gem_updates ]--------------------------------<

say_recipe 'Gem Updates'

gsub_file 'Gemfile', /"mongoid", ">= 2.0.0.beta.19"/, '"mongoid", ">= 2.0.0.rc.7"'
gsub_file 'Gemfile', /"devise"/, '"devise", ">= 1.2.rc"'

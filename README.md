# Rails Wizard Config

Select the recipes you would like to include and add some like the following to the *Customize Template* section at <http://railswizard.org/>:

    repo = "https://github.com/fnichol/rails-template-recipes"
    extra_recipes = %w{ git cleanup cucumber_extras }
    extra_recipes.each { |r| apply "#{repo}/raw/master/#{r}.rb" }


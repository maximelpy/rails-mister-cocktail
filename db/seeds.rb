# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Cocktail.destroy_all
Ingredient.destroy_all


require "open-uri"
require "faker"

url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"

ingredients = JSON.parse(open(url).read)
ingredients["drinks"].each do |i|
  Ingredient.create!(name: i["strIngredient1"])
end


10.times do
  cocktail = Cocktail.create!(
    name: Faker::GreekPhilosophers.unique.name
  )
  3.times do
    dose = Dose.new(description: ["2 onces", "just a finger", "50%"].sample)
    dose.cocktail = cocktail
    dose.ingredient = Ingredient.all.sample
    dose.save!
  end
end

# dose = Dose.new(description: "2 onces")
# dose.cocktail = Cocktail.first
# dose.ingredient = Ingredient.first
# dose.save!


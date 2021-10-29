# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
cats = [
  {
    name: 'Tama',
    age: 1,
    enjoys: 'He likes to catch flies and eat them.'
  },
  {
    name: 'Kitkat',
    age: 2,
    enjoys: 'Climbing on the wall.'
  },
  {
    name: 'Godiva',
    age: 2,
    enjoys: 'Hunting animals outside.'
  },
  {
    name: 'Nala',
    age: 2,
    enjoys: 'Going outside and hunting animals.'
  }
]

cats.each do |attributes|
  Cat.create attributes
  puts "creating cat #{attributes}"
end

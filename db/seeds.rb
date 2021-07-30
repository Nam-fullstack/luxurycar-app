# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

makes = ['Aston Martin', 'Audi', 'Bentley', 'BMW', 'Bugatti', 'Ferrari', 'Hennessey', 'Koenigsegg', 'Lamborghini', 'Land Rover', 'Lexus', 'Lotus', 'Maserati', 'McLaren', 'Mercedes-Benz', 'Porsche', 'Rolls-Royce', 'SSC', 'Tesla', 'W Motors']
years = 1950..2021
transmissions = ['Automatic', 'Manual']
fuel_types = ['Diesel', 'Dual Fuel', 'Electric', 'Gas Only', 'Hybrid', 'Petrol', 'Plug in Hybrid']
engines = ['Electric', 'V2', 'V3', 'V4', 'Inline 5', 'V6', 'Inline 6', 'V8', 'V10', 'V12', 'W16']
body_types = ['Convertible', 'Coupe', 'Hatch', 'Sedan', 'SUV', 'Wagon']
colours = ['Beige', 'Black', 'Blue', 'Bronze', 'Brown', 'Burgundy', 'Gold', 'Green', 'Grey', 'Magenta', 'Maroon', 'Orange', 'Other', 'Pink', 'Purple', 'Red', 'Silver', 'White', 'Yellow']

if User.count.zero?
  User.create(
    username: "administrator",
    email: "admin@admin.com",
    password: "administrator"
  )
  puts "Created Admin"
  
  User.create(
    username: "test",
    email: "test@test.com",
    password: "testing"
  )
  puts "Created test User"
end

if Make.count.zero?
  makes.each do |make|
    Make.create(name: make)
    puts "Created #{make} make"
  end
end

if Year.count.zero?
  years.each do |year|
    Year.create(year: year)
    puts "Created #{year} year"
  end
end

if Transmission.count.zero?
  transmissions.each do |transmission|
    Transmission.create(name: transmission)
    puts "Created #{transmission} transmission"
  end
end

if Fuel.count.zero?
  fuel_types.each do |fuel|
    Fuel.create(name: fuel)
    puts "Created #{fuel} fuel type"
  end
end

if Engine.count.zero?
  engines.each do |engine|
    Engine.create(name: engine)
    puts "Created #{engine} engine"
  end
end


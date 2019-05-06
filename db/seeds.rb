# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

print "clear User:"
User.destroy_all
puts " ✔"
print "clear Event:"
Event.destroy_all
puts " ✔"
print "clear Participation:"
Participation.destroy_all
puts " ✔ \n\n"


print 'create User'
3.times do |index|
  first_name = Faker::Name.first_name
  User.create(
    email: "#{first_name}@yopmail.com",
    description: Faker::Lorem.words(30).join(" ").capitalize,
    first_name: first_name,
    last_name: Faker::Name.last_name
  )
end
puts " ✔"

print 'create Events'
3.times do |index|
  Event.create(
    start_date: Faker::Date.forward(days = 365),
    duration: rand(1..200)*5,
    title: Faker::Lorem.words(5).join(" ").capitalize,
    description: Faker::Lorem.words(50).join(" ").capitalize,
    price: rand(1..1000),
    location: Faker::Address.city,
    admin_id: User.all.sample.id
  )
end
puts " ✔"

print 'create participation'
3.times do |index|
  Participation.create(
    user_id: User.all.sample.id,
    event_id: Event.all.sample.id
  )
end
puts " ✔"

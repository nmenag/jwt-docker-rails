# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: 'Admin', email: 'admin@example.com', role: :admin, password: 'pass1234', active: true)
User.create(name: 'user 1', email: 'user1@example.com', role: :role_one, password: 'pass1234', active: true)
User.create(name: 'user 2', email: 'user2@example.com', role: :role_two, password: 'pass1234', active: true)

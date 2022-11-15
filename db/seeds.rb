# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

HelpPortal.create(title: "Privacy Policy", description: "it is a privacy policy", help_type: "Privacy Policy" )
HelpPortal.create(title: "Term And Condition", description: "It is a Term and condition", help_type: "Term And Condition" )
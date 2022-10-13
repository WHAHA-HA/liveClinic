# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AccessLevel.create(name: "Staff")
AccessLevel.create(name: "Nurse")
AccessLevel.create(name: "Phys.")
AccessLevel.create(name: "MO")
AccessLevel.create(name: "DO")

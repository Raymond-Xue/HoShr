# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

City.delete_all
State.delete_all
Country.delete_all



require 'city-state'
country_list = CS.get

Country.create(country_abbr: "US", country_name: "United State")
State.create(state_abbr: "MA", state_name: "Massachusetts", country_id: 1)
City.create(city_name: "Waltham", state_id: 1)
Type.create(type_name: "House")

# Full state and city list

# state_list = CS.get("US")
# sid = 1
# state_list.each do |sabbr, sname|
# 	State.create(state_abbr: sabbr, state_name: sname, country_id: 1)
# 	city_list = CS.get("US", sabbr)
# 	city_list.each do |cabbr, cname|
# 		City.create(city_abbr: cabbr, city_name: cname, state_id: sid)
# 	end
# 	sid += 1
# 	puts "loading state: ", sname, "\n"
# end


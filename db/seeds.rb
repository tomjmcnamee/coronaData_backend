# # # # If the DB is populated, but you want to wipe it out to start with a fresh seeding, 
# # # # run the below command first:
# # # #       "rails db:migrate:reset"  
# # # # This will drop all, create the DB (with all tables), then remigrate all.\
# # * Database creation
# #   #$   rails db:create
# #   #$   rails db:migrate
# #   #$   rails db:seed
# --------------------------------




puts "Create States -- START"
State.create!(id: 1, state_name: "Alabama", state_abbreviation: "AL")
State.create!(id: 2, state_name: "Alaska", state_abbreviation: "AK")
State.create!(id: 3, state_name: "Arizona", state_abbreviation: "AZ")
State.create!(id: 4, state_name: "Arkansas", state_abbreviation: "AR")
State.create!(id: 5, state_name: "California", state_abbreviation: "CA")
State.create!(id: 6, state_name: "Colorado", state_abbreviation: "CO")
State.create!(id: 7, state_name: "Connecticut", state_abbreviation: "CT")
State.create!(id: 8, state_name: "Delaware", state_abbreviation: "DE")
State.create!(id: 9, state_name: "Florida", state_abbreviation: "FL")
State.create!(id: 10, state_name: "Georgia", state_abbreviation: "GA")
State.create!(id: 11, state_name: "Hawaii", state_abbreviation: "HI")
State.create!(id: 12, state_name: "Idaho", state_abbreviation: "ID")
State.create!(id: 13, state_name: "Illinois", state_abbreviation: "IL")
State.create!(id: 14, state_name: "Indiana", state_abbreviation: "IN")
State.create!(id: 15, state_name: "Iowa", state_abbreviation: "IA")
State.create!(id: 16, state_name: "Kansas", state_abbreviation: "KS")
State.create!(id: 17, state_name: "Kentucky", state_abbreviation: "KY")
State.create!(id: 18, state_name: "Louisiana", state_abbreviation: "LA")
State.create!(id: 19, state_name: "Maine", state_abbreviation: "ME")
State.create!(id: 20, state_name: "Maryland", state_abbreviation: "MD")
State.create!(id: 21, state_name: "Massachusetts", state_abbreviation: "MA")
State.create!(id: 22, state_name: "Michigan", state_abbreviation: "MI")
State.create!(id: 23, state_name: "Minnesota", state_abbreviation: "MN")
State.create!(id: 24, state_name: "Mississippi", state_abbreviation: "MS")
State.create!(id: 25, state_name: "Missouri", state_abbreviation: "MO")
State.create!(id: 26, state_name: "Montana", state_abbreviation: "MT")
State.create!(id: 27, state_name: "Nebraska", state_abbreviation: "NE")
State.create!(id: 28, state_name: "Nevada", state_abbreviation: "NV")
State.create!(id: 29, state_name: "New Hampshire", state_abbreviation: "NH")
State.create!(id: 30, state_name: "New Jersey", state_abbreviation: "NJ")
State.create!(id: 31, state_name: "New Mexico", state_abbreviation: "NM")
State.create!(id: 32, state_name: "New York", state_abbreviation: "NY")
State.create!(id: 33, state_name: "North Carolina", state_abbreviation: "NC")
State.create!(id: 34, state_name: "North Dakota", state_abbreviation: "ND")
State.create!(id: 35, state_name: "Ohio", state_abbreviation: "OH")
State.create!(id: 36, state_name: "Oklahoma", state_abbreviation: "OK")
State.create!(id: 37, state_name: "Oregon", state_abbreviation: "OR")
State.create!(id: 38, state_name: "Pennsylvania", state_abbreviation: "PA")
State.create!(id: 39, state_name: "Rhode Island", state_abbreviation: "RI")
State.create!(id: 40, state_name: "South Carolina", state_abbreviation: "SC")
State.create!(id: 41, state_name: "South Dakota", state_abbreviation: "SD")
State.create!(id: 42, state_name: "Tennessee", state_abbreviation: "TN")
State.create!(id: 43, state_name: "Texas", state_abbreviation: "TX")
State.create!(id: 44, state_name: "Utah", state_abbreviation: "UT")
State.create!(id: 45, state_name: "Vermont", state_abbreviation: "VT")
State.create!(id: 46, state_name: "Virginia", state_abbreviation: "VA")
State.create!(id: 47, state_name: "Washington", state_abbreviation: "WA")
State.create!(id: 48, state_name: "Washington DC", state_abbreviation: "DC")
State.create!(id: 49, state_name: "West Virginia", state_abbreviation: "WV")
State.create!(id: 50, state_name: "Wisconsin", state_abbreviation: "WI")
State.create!(id: 51, state_name: "Wyoming", state_abbreviation: "WY")
State.create!(id: 52, state_name: "American Samoa", state_abbreviation: "AS")
State.create!(id: 53, state_name: "Puerto Rico", state_abbreviation: "PR")
State.create!(id: 54, state_name: "US Virgin Islands", state_abbreviation: "VI")
State.create!(id: 55, state_name: "Guam", state_abbreviation: "GU")
State.create!(id: 56, state_name: "Northern Mariana Islands", state_abbreviation: "MP")
puts "Create States -- END"

puts "CREATE DB ROW Records -- START"
for state in State.all do
  for t in [ "positive", "negative", "hospitalized", "death", "total"] do
    ProcessedStat.create(state_id: state.id, count_type: "#{"total-" + t}")
    ProcessedStat.create(state_id: state.id, count_type: "#{"new-" + t}")
  end
end
puts "CREATE DB ROW Records -- END"
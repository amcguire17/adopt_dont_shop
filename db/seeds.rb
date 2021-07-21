# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PetApplication.destroy_all
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all

@yesterday = Shelter.create!(name: 'Yesterday Dog Shelter', address: '116 Penny Ln', city: 'Liverpool, UK', zip_code: 'L18 1DQ', foster_program: false, rank: 9)
@yellow = Shelter.create!(name: 'Yellow Submarine Cat Shelter', address: 'Melcombe Place, Marylebone', city: 'London, UK', zip_code: 'NW1 6JJ', foster_program: true, rank: 6)
@together = Shelter.create!(name: 'Come Together Turtle Rescue', address: '61 Abbey Rd', city: 'London, UK', zip_code: 'NW8 0AD', foster_program: true, rank: 7)
@strawberry = Shelter.create!(name: 'Strawberry Field Horse Rescue', address: '16 Beaconsfield Rd', city: 'Liverpool, UK', zip_code: 'L25 6EJ', foster_program: false, rank: 8)


@dudes = @yesterday.pets.create!(name: 'Jude and Dude', breed: 'dachshund', age: 1, adoptable: true)
@abbey = @yesterday.pets.create!(name: 'Abbey', breed: 'bernese mountain dog', age: 5, adoptable: true)
@sadie = @yesterday.pets.create!(name: 'Sadie', breed: 'retriever', age: 8, adoptable: true)
@lucy = @yesterday.pets.create!(name: 'Lucy', breed: 'bulldog', age: 2, adoptable: true)

@eleanor = @yellow.pets.create!(name: 'Eleanor Rigby', breed: 'british shorthair', age: 9, adoptable: true)
@penny = @yellow.pets.create!(name: 'Penny', breed: 'ragamuffin', age: 2, adoptable: true)
@sun = @yellow.pets.create!(name: 'Sun King', breed: 'scottish fold', age: 4, adoptable: true)
@helter = @yellow.pets.create!(name: 'Helter Skelter', breed: 'maine coon', age: 6, adoptable: true)

@octopus = @together.pets.create!(name: "Octopus's Garden", breed: 'painted', age: 25, adoptable: true)
@rocky = @together.pets.create!(name: 'Rocky Raccoon', breed: 'red ear slider', age: 10, adoptable: true)
@maxwell = @together.pets.create!(name: 'Maxwell', breed: 'box', age: 1, adoptable: true)
@blackbird = @together.pets.create!(name: 'Blackbird', breed: 'yellow-bellied slider', age: 17, adoptable: true)

@lizzy = @strawberry.pets.create!(name: 'Miss Lizzy', breed: 'appaloosa', age: 10, adoptable: true)
@pepper = @strawberry.pets.create!(name: 'Sgt. Pepper', breed: 'paint', age: 15, adoptable: true)
@honey = @strawberry.pets.create!(name: 'Honey Pie', breed: 'grade', age: 12, adoptable: true)
@piggies = @strawberry.pets.create!(name: 'Piggies', breed: 'shetland', age: 8, adoptable: true)

@paul = Application.create(applicant_name: 'Paul McCartney',
                            applicant_street_address: '7 Cavendish Ave',
                            applicant_city: 'London',
                            applicant_state: 'UK',
                            applicant_zip_code: 'NW8 9JG',
                            description: 'And when the night is cloudy there is still a light that shines on me shinin until tomorrow, let it be',
                            status: 'Pending'
                          )
@john = Application.create(applicant_name: 'John Lennon',
                            applicant_street_address: '251 Menlove Avenue',
                            applicant_city: 'Liverpool',
                            applicant_state: 'UK',
                            applicant_zip_code: 'L25 7SA',
                            description: '',
                            status: 'In Progress'
                          )
@george = Application.create(applicant_name: 'George Harrison',
                            applicant_street_address: '57 Green Street, Mayfair',
                            applicant_city: 'London',
                            applicant_state: 'UK',
                            applicant_zip_code: 'W1K 6RH',
                            description: '',
                            status: 'In Progress'
                          )
@ringo = Application.create(applicant_name: 'Ringo Starr',
                            applicant_street_address: '25 Matthew Street',
                            applicant_city: 'Liverpool',
                            applicant_state: 'UK',
                            applicant_zip_code: 'L2 6RE',
                            description: 'We would be warm below the storm in our little hide-a-way beneath the waves',
                            status: 'Pending'
                          )
PetApplication.create!(application: @paul, pet: @penny)
PetApplication.create!(application: @paul, pet: @helter)
PetApplication.create!(application: @ringo, pet: @octopus)

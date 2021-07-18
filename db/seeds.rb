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

@dumb = Shelter.create(name: 'Dumb Friends League', city: 'Denver, CO', foster_program: false, rank: 9)

@hercules = @dumb.pets.create(name: 'Hercules', breed: 'pitbull/boxer', age: 2, adoptable: true)
@tuti = @dumb.pets.create(name: 'Tuti', breed: 'german shepherd', age: 9, adoptable: true)
@ayo = @dumb.pets.create(name: 'Ayo', breed: 'chow mix', age: 11, adoptable: true)
@beauty = @dumb.pets.create(name: 'Beauty', breed: 'shorthair', age: 9, adoptable: true)
@dove = @dumb.pets.create(name: 'Dove', breed: 'shorthair', age: 2, adoptable: true)
@bugatti = @dumb.pets.create(name: 'Bugatti', breed: 'shorthair', age: 10, adoptable: true)
@cinnabar = @dumb.pets.create(name: 'Cinnabar', breed: 'appaloosa', age: 10, adoptable: true)
@honey = @dumb.pets.create(name: 'Honey', breed: 'Paint', age: 17, adoptable: true)
@lavender = @dumb.pets.create(name: 'Lavender', breed: 'grade', age: 10, adoptable: true)

@henry = Application.create(applicant_name: 'Henry',
                            applicant_street_address: '123 A Street',
                            applicant_city: 'Aurora',
                            applicant_state: 'CO',
                            applicant_zip_code: '800120',
                            description: 'I have the perfect set up for an animal',
                            status: 'In Progress'
                          )

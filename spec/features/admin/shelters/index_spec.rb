require 'rails_helper'

RSpec.describe 'the shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', address: '1234 North Street', city: 'Aurora, CO', zip_code: '80010', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', address: '6789 5th Street', city: 'Harlingen, TX', zip_code: '78551', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', address: '5873 186th Avenue', city: 'Denver, CO', zip_code: '80120', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @app_1 = Application.create!(applicant_name: 'Freddy', applicant_street_address: '13 Walk Way', applicant_city: 'Aurora', applicant_state: 'CO', applicant_zip_code: '82012', description: 'applying for pet', status: 'Approved')
    @app_2 = Application.create!(applicant_name: 'Yolanda Garcia', applicant_street_address: '5274 Arapahoe Road', applicant_city: 'Centennial', applicant_state: 'CO', applicant_zip_code: '80110', description: 'Pets are neat', status: 'Pending')
    @app_1.pets << @pet_1
    @app_2.pets << @pet_2
    visit '/admin/shelters'
  end

  it 'lists all the shelters by name in reverse' do
    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  it 'lists shelters with pending applications' do
    within('#pending-app') do
      expect(page).to have_content(@shelter_1.name)
    end
  end

  it 'lists shelters with pending applications' do
    app = Application.create!(applicant_name: 'Freddy', applicant_street_address: '13 Walk Way', applicant_city: 'Aurora', applicant_state: 'CO', applicant_zip_code: '82012', description: 'applying for pet', status: 'Pending')
    app.pets << @pet_3

    visit '/admin/shelters'

    within('#pending-app') do
      expect(@shelter_1.name).to appear_before(@shelter_3.name)
    end
  end
end

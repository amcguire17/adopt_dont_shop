require 'rails_helper'

RSpec.describe 'the shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @app_1 = Application.create!(applicant_name: 'Freddy', applicant_street_address: '13 Walk Way', applicant_city: 'Aurora', applicant_state: 'CO', applicant_zip_code: '82012', description: 'applying for pet', status: 'Approved')
    @app_2 = Application.create!(applicant_name: 'Yolanda Garcia', applicant_street_address: '5274 Arapahoe Road', applicant_city: 'Centennial', applicant_state: 'CO', applicant_zip_code: '80110', description: 'Pets are neat', status: 'Pending')
    @app_1.pets << @pet_1
    @app_2.pets << @pet_2
  end

  it 'lists all the shelters by name in reverse' do
    visit '/admin/shelters'

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  it 'lists shelters with pending applications' do
    visit '/admin/shelters'

    within('#pending-app') do
      expect(page).to have_content(@shelter_1.name)
    end
  end
end

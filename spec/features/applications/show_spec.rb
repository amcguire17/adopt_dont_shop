require 'rails_helper'

RSpec.describe 'Application Show Page' do
  it 'shows an application and all attributes' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    app = Application.create!(applicant_name: 'Freddy', applicant_street_address: '13 Walk Way', applicant_city: 'Aurora', applicant_state: 'CO', applicant_zip_code: '82012', description: 'Best friend', status: 'In Progress')
    app.pets << pet_1
    app.pets << pet_2

    visit "/applications/#{app.id}"
    save_and_open_page
    expect(page).to have_content(app.applicant_name)
    expect(page).to have_content(app.applicant_street_address)
    expect(page).to have_content(app.applicant_city)
    expect(page).to have_content(app.applicant_state)
    expect(page).to have_content(app.applicant_zip_code)
    expect(page).to have_content(app.description)
    expect(page).to have_content(app.status)
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
  end
end

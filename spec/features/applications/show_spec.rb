require 'rails_helper'

RSpec.describe 'Application Show Page' do
  before :each do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @app = Application.create!(applicant_name: 'Freddy', applicant_street_address: '13 Walk Way', applicant_city: 'Aurora', applicant_state: 'CO', applicant_zip_code: '82012', status: 'In Progress')
  end
  it 'shows an application and all attributes' do
  it 'can search for a pet' do
    visit "/applications/#{@app.id}"

    fill_in :search, with: 'Lobster'
    click_button 'Search'

    expect(current_path).to eq("/applications/#{@app.id}")
    expect(page).to have_content('Lobster')

  end

  it 'can search for animal by partial matches' do
    visit "/applications/#{@app.id}"

    fill_in :search, with: 'Lob'
    click_button 'Search'

    expect(current_path).to eq("/applications/#{@app.id}")
    expect(page).to have_content('Lobster')
  end

  it 'can search for animal by case insensitive' do
    visit "/applications/#{@app.id}"

    fill_in :search, with: 'lucille'
    click_button 'Search'

    expect(current_path).to eq("/applications/#{@app.id}")
    expect(page).to have_content('Lucille Bald')
  end
end

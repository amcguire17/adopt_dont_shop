require 'rails_helper'

RSpec.describe 'Application Show Page' do
  before :each do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @app = Application.create!(applicant_name: 'Freddy', applicant_street_address: '13 Walk Way', applicant_city: 'Aurora', applicant_state: 'CO', applicant_zip_code: '82012', status: 'In Progress')
  end
  it 'shows an application and all attributes' do
    @app.pets << @pet_1
    @app.pets << @pet_2

    visit "/applications/#{@app.id}"

    expect(page).to have_content(@app.applicant_name)
    expect(page).to have_content(@app.applicant_street_address)
    expect(page).to have_content(@app.applicant_city)
    expect(page).to have_content(@app.applicant_state)
    expect(page).to have_content(@app.applicant_zip_code)
    expect(page).to have_content(@app.status)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
  end

  it 'can search for a pet' do
    visit "/applications/#{@app.id}"

    fill_in :search, with: 'Lobster'
    click_button 'Search'

    expect(current_path).to eq("/applications/#{@app.id}")
    expect(page).to have_content('Lobster')

  end

  it 'can add pet to application' do
    visit "/applications/#{@app.id}"

    fill_in :search, with: 'Lobster'
    click_button 'Search'

    within("#Pet-#{@pet_2.id}") do
      click_button 'Adopt this Pet'
    end

    expect(current_path).to eq("/applications/#{@app.id}")
    expect(@app.pets).to eq([@pet_2])
  end

  it 'can submit and enter description when pets have been selected' do
    @app.pets << @pet_2

    visit "/applications/#{@app.id}"

    fill_in :description, with: 'I have a big yard'
    click_button 'Submit Application'

    expect(current_path).to eq("/applications/#{@app.id}")
    expect(page).to have_content("Pending")
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content('I have a big yard')
    expect(page).to_not have_content('Add Pets to Adopt:')
  end

  it 'can return error message when all fields are not filled in' do
    @app.pets << @pet_2

    visit "/applications/#{@app.id}"

    fill_in :description, with: ''
    click_button 'Submit Application'

    click_button 'Submit'

    expect(page).to have_current_path("/applications/#{@app.id}")
    expect(page).to have_content("Error: Description can't be blank")
  end

  it 'cannot submit form if not animals have been selected' do
    visit "/applications/#{@app.id}"

    expect(page).to_not have_button('Submit Application')
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

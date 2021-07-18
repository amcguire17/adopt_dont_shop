require 'rails_helper'

RSpec.describe 'New Application' do
  it 'can link to new applicaiton from pet index page' do
    visit '/pets'

    click_link 'New Application'

    expect(current_path).to eq('/applications/new')
  end

  it 'can fill out a form' do
    visit '/applications/new'

    fill_in :applicant_name, with: 'Cynthia Brown'
    fill_in :applicant_street_address, with: '765 Bee Drive'
    fill_in :applicant_city, with: 'Elizabethton'
    fill_in :applicant_state, with: 'TN'
    fill_in :applicant_zip_code, with: '37644'
    fill_in :description, with: 'I have lots of space and a nice yard'
    click_button 'Submit'

    expect(page).to have_content('Cynthia Brown')
    expect(page).to have_content('765 Bee Drive')
    expect(page).to have_content('Elizabethton')
    expect(page).to have_content('TN')
    expect(page).to have_content('37644')
    expect(page).to have_content('I have lots of space and a nice yard')
    expect(page).to have_content('In Progress')
  end
end

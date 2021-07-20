require 'rails_helper'

RSpec.describe 'Application Show Page' do
  before :each do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @app = Application.create!(applicant_name: 'Freddy', applicant_street_address: '13 Walk Way', applicant_city: 'Aurora', applicant_state: 'CO', applicant_zip_code: '82012', description: 'Please let me adopt a pet', status: 'Pending')
    @app.pets << @pet_1
    @app.pets << @pet_2
    visit "/admin/applications/#{@app.id}"
  end

  it 'can approve an application show a pet has been adopted' do
    within("#pet-#{@pet_1.id}") do
      click_button 'Approve Application'
    end

    expect(page).to_not have_content('Approve Application')
    expect(page).to have_content('Pet Approved')

    within("#pet-#{@pet_2.id}") do
      expect(page).to have_button('Approve Application')
    end
  end

  it 'can reject an application show a pet has been rejected' do
    within("#pet-#{@pet_1.id}") do
      click_button 'Reject Application'
    end

    expect(page).to_not have_content('Reject Application')
    expect(page).to_not have_content('Approve Application')
    expect(page).to have_content('Pet Rejected')

    within("#pet-#{@pet_2.id}") do
      expect(page).to have_button('Approve Application')
      expect(page).to have_button('Reject Application')
    end
  end

  it 'does not allow to approve or reject all pets once they have been updated' do
    within("#pet-#{@pet_1.id}") do
      click_button 'Reject Application'
    end

    expect(page).to_not have_content('Reject Application')
    expect(page).to_not have_content('Approve Application')
    expect(page).to have_content('Pet Rejected')

    within("#pet-#{@pet_2.id}") do
      click_button 'Approve Application'
    end

    expect(page).to_not have_content('Reject Application')
    expect(page).to_not have_content('Approve Application')
    expect(page).to have_content('Pet Approved')
  end

  it 'can reject or approve application without affecting another applications' do
    app_2 = Application.create!(applicant_name: 'Yolanda Garcia', applicant_street_address: '5274 Arapahoe Road', applicant_city: 'Centennial', applicant_state: 'CO', applicant_zip_code: '80110', description: 'Pets are neat', status: 'Pending')
    app_2.pets << @pet_1

    within("#pet-#{@pet_1.id}") do
      click_button 'Approve Application'
    end

    visit "/admin/applications/#{app_2.id}"

    expect(page).to have_button('Approve Application')
    expect(page).to have_button('Reject Application')
  end

  it 'application status changes to approve if all pets have been approved' do
    within("#pet-#{@pet_1.id}") do
      click_button 'Approve Application'
    end
    within("#pet-#{@pet_2.id}") do
      click_button 'Approve Application'
    end

    expect(page.find('h2')).to have_content('Approved')
  end

  it 'application status changes to reject if any pets have been rejected' do
    within("#pet-#{@pet_1.id}") do
      click_button 'Reject Application'
    end
    within("#pet-#{@pet_2.id}") do
      click_button 'Approve Application'
    end

    expect(page.find('h2')).to have_content('Rejected')
  end

  it 'when application has been approved pet is no longer adoptable' do
    within("#pet-#{@pet_1.id}") do
      click_button 'Approve Application'
    end
    within("#pet-#{@pet_2.id}") do
      click_button 'Approve Application'
    end

    visit "/pets/#{@pet_1.id}"

    expect(page).to have_content(false)
  end

  it 'when application has been approved other applications with pet cannot approve for adoption' do
    app_2 = Application.create!(applicant_name: 'Yolanda Garcia', applicant_street_address: '5274 Arapahoe Road', applicant_city: 'Centennial', applicant_state: 'CO', applicant_zip_code: '80110', description: 'Pets are neat', status: 'Pending')
    app_2.pets << @pet_1

    within("#pet-#{@pet_1.id}") do
      click_button 'Approve Application'
    end
    within("#pet-#{@pet_2.id}") do
      click_button 'Approve Application'
    end

    visit "/admin/applications/#{app_2.id}"

    within("#pet-#{@pet_1.id}") do

    end

    expect(page).to_not have_button('Approve Application')
  end
end

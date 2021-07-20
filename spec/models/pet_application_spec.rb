require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end

  before :each do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', address: '1234 North Street', city: 'Aurora, CO', zip_code: '80010', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create!(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @app = Application.create!(applicant_name: 'Freddy', applicant_street_address: '13 Walk Way', applicant_city: 'Aurora', applicant_state: 'CO', applicant_zip_code: '82012', description: 'I like animals', status: 'In Progress')
    @petapp_1 = PetApplication.create!(pet: @pet_1, application: @app, status: 'Rejected')
    @petapp_2 = PetApplication.create!(pet: @pet_2, application: @app, status: 'Approved')
    @petapp_3 = PetApplication.create!(pet: @pet_3, application: @app, status: 'Rejected')
  end

  describe 'class methods' do
    describe '.find_by_pet_and_app_id' do
      it 'finds the object by pet and app ids' do
        expect(PetApplication.find_by_pet_and_app_id(@app.id, @pet_2.id)).to eq(@petapp_2)
      end
    end

    describe '.status_list_by_application' do
      it 'finds list of status app ids' do
        expect(PetApplication.status_list_by_application(@app.id)).to eq(['Rejected', 'Approved', 'Rejected'])
      end
    end
  end
end

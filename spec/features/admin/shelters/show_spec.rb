require 'rails_helper'

RSpec.describe 'Admin Shelter Show Page' do
  before :each do
    @shelter = Shelter.create!(name: 'Aurora shelter', address: '1234 North Street', city: 'Aurora, CO', zip_code: '80010', foster_program: false, rank: 9)
    @pet_1 = @shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    visit "/admin/shelters/#{@shelter.id}"
  end

  it 'can see shelter name and full address' do
    expect(page).to have_content(@shelter.name)
    expect(page).to have_content("#{@shelter.address}, #{@shelter.city} #{@shelter.zip_code}" )
  end

  describe 'Shelter Statistics' do
    it 'shows average pet age of shelter' do
      expect(page).to have_content('Average Pet Age: 4')
    end

    it 'shows number of adoptable pets of shelter' do
      expect(page).to have_content('Adoptable Pet Count: 2')
    end

  end
end

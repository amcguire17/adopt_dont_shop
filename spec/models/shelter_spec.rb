require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many(:pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:rank) }
    it { should validate_numericality_of(:rank) }
  end

  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', address: '1234 North Street', city: 'Aurora, CO', zip_code: '80010', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', address: '6789 5th Street', city: 'Harlingen, TX', zip_code: '78551', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', address: '5873 186th Avenue', city: 'Denver, CO', zip_code: '80120', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Shelter.search("Fancy")).to eq([@shelter_3])
      end
    end

    describe '#order_by_recently_created' do
      it 'returns shelters with the most recently created first' do
        expect(Shelter.order_by_recently_created).to eq([@shelter_3, @shelter_2, @shelter_1])
      end
    end

    describe '#order_by_number_of_pets' do
      it 'orders the shelters by number of pets they have, descending' do
        expect(Shelter.order_by_number_of_pets).to eq([@shelter_1, @shelter_3, @shelter_2])
      end
    end

    describe '#order_by_name' do
      it 'orders the shelters by name, descending' do
        expect(Shelter.order_by_name).to eq([@shelter_2, @shelter_3, @shelter_1])
      end
    end

    describe '#pending_applications' do
      it 'returns all shelters with pending applications' do
        app_1 = Application.create!(applicant_name: 'Freddy', applicant_street_address: '13 Walk Way', applicant_city: 'Aurora', applicant_state: 'CO', applicant_zip_code: '82012', description: 'applying for pet', status: 'Approved')
        app_2 = Application.create!(applicant_name: 'Yolanda Garcia', applicant_street_address: '5274 Arapahoe Road', applicant_city: 'Centennial', applicant_state: 'CO', applicant_zip_code: '80110', description: 'Pets are neat', status: 'Pending')
        app_1.pets << @pet_1
        app_2.pets << @pet_2
        expect(Shelter.pending_applications).to eq([@shelter_1])
      end
    end

    describe '#full_address' do
      it 'returns the full address of a shelter' do
        expect(Shelter.full_address(@shelter_1.id)).to eq('1234 North Street, Aurora, CO 80010')
      end
    end
  end

  describe 'instance methods' do
    describe '.adoptable_pets' do
      it 'only returns pets that are adoptable' do
        expect(@shelter_1.adoptable_pets).to eq([@pet_2, @pet_4])
      end
    end

    describe '.alphabetical_pets' do
      it 'returns pets associated with the given shelter in alphabetical name order' do
        expect(@shelter_1.alphabetical_pets).to eq([@pet_4, @pet_2])
      end
    end

    describe '.shelter_pets_filtered_by_age' do
      it 'filters the shelter pets based on given params' do
        expect(@shelter_1.shelter_pets_filtered_by_age(5)).to eq([@pet_4])
      end
    end

    describe '.pet_count' do
      it 'returns the number of pets at the given shelter' do
        expect(@shelter_1.pet_count).to eq(3)
      end
    end

    describe '.adoptable_pet_count' do
      it 'returns the number of pets that are adoptable' do
        expect(@shelter_1.adoptable_pet_count).to eq(2)
      end
    end

    describe '.average_pet_age' do
      it 'returns the average age of pets at given shelter' do
        expect(@shelter_1.average_pet_age).to eq(4)
      end
    end

    describe '.adopted_pet_count' do
      it 'returns the number of pets that have been adopted' do
        app = Application.create!(applicant_name: 'Freddy', applicant_street_address: '13 Walk Way', applicant_city: 'Aurora', applicant_state: 'CO', applicant_zip_code: '82012', description: 'I like pets', status: 'Approved')
        PetApplication.create!(application: app, pet: @pet_1, status: 'Approved')
        expect(@shelter_1.adopted_pet_count).to eq(1)
      end
    end

    describe '.pets_pending_applications' do
      it 'returns all pets with a pending applications' do
        app = Application.create!(applicant_name: 'Freddy', applicant_street_address: '13 Walk Way', applicant_city: 'Aurora', applicant_state: 'CO', applicant_zip_code: '82012', description: 'I like pets', status: 'Pending')
        PetApplication.create!(application: app, pet: @pet_2, status: 'Pending')
        PetApplication.create!(application: app, pet: @pet_4, status: 'Pending')
        expect(@shelter_1.pets_pending_applications).to eq([@pet_2, @pet_4])
      end
    end
  end
end

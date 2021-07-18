require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of(:applicant_name) }
    it { should validate_presence_of(:applicant_street_address) }
    it { should validate_presence_of(:applicant_city) }
    it { should validate_presence_of(:applicant_state) }
    it { should validate_presence_of(:applicant_zip_code) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
  end
end
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
    it { should validate_presence_of(:status) }
    context "if status is not in progress" do
      before { allow(subject).to receive(:status_not_in_progress?).and_return(true) }
      it { should validate_presence_of(:description) }
    end

    context "if status is in progress" do
      before { allow(subject).to receive(:status_not_in_progress?).and_return(false) }
      it { should_not validate_presence_of(:description) }
    end
  end
end

class Application < ApplicationRecord
  validates :applicant_name, presence: true
  validates :applicant_street_address, presence: true
  validates :applicant_city, presence: true
  validates :applicant_state, presence: true
  validates :applicant_zip_code, presence: true
  validates_presence_of :description, :unless => Proc.new { |ex| ex.status == 'In Progress' }
  validates :status, presence: true
  has_many :pet_applications
  has_many :pets, through: :pet_applications
end

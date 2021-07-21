class Application < ApplicationRecord
  validates :applicant_name, presence: true
  validates :applicant_street_address, presence: true
  validates :applicant_city, presence: true
  validates :applicant_state, presence: true
  validates :applicant_zip_code, presence: true
  validates :status, presence: true
  validates :description, presence: true, if: :status_not_in_progress?
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def status_not_in_progress?
    status != 'In Progress'
  end
end

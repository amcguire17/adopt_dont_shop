class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.find_by_pet_and_app_id(id1, id2)
    where(application_id: id1, pet_id: id2).first
  end
end

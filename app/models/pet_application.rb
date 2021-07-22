class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.find_by_pet_and_app_id(id1, id2)
    where(application_id: id1, pet_id: id2).first
  end

  def self.status_list_by_application(id)
    where(application_id: id).pluck(:status)
  end

  def self.all_pets_on_application_reviewed?(id)
    status_list_by_application(id).exclude?('Pending')
  end

  def self.pet_rejected_on_complete_application?(id)
    all_pets_on_application_reviewed?(id) && status_list_by_application(id).include?('Rejected')
  end
end

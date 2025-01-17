class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def self.order_by_name
    Shelter.find_by_sql("SELECT * FROM shelters ORDER BY shelters.name desc")
  end

  def self.pending_applications
    Shelter.joins(pets: [:applications]).where('applications.status = ?', 'Pending').order(:name).distinct
  end

  def self.full_address(id)
    find_by_sql("SELECT concat(address,', ', city, ' ', zip_code) as full_address  FROM shelters WHERE id = #{id}").pluck(:full_address).first
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end

  def adoptable_pet_count
    adoptable_pets.count
  end

  def average_pet_age
    pets.average(:age).to_i
  end

  def adopted_pet_count
    pets.select('applications.*').joins(:applications).where('applications.status = ?', 'Approved').count
  end

  def pets_pending_applications
    pets.joins(:applications).where('applications.status = ?', 'Pending').distinct
  end
end

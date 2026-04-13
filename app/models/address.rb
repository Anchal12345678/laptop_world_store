class Address < ApplicationRecord
  belongs_to :user
  validates :street_address, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id user_id street_address city province postal_code country created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['user']
  end
end

class Category < ApplicationRecord
  has_many :products
  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name description created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['products']
  end
end

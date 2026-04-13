class Tag < ApplicationRecord
  has_many :product_tags
  has_many :products, through: :product_tags
  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['products']
  end
end

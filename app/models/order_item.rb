class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id order_id product_id quantity unit_price line_total created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[order product]
  end
end

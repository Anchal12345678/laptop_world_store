class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  validates :name, presence: true
  validates :current_price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :sale_price, numericality: { greater_than_or_equal_to: 0.01 }, allow_blank: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "description", "current_price", "sale_price",
     "on_sale", "stock_quantity", "category_id", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
end

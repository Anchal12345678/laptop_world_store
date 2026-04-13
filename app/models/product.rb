class Product < ApplicationRecord
  belongs_to :category
  has_many :product_tags
has_many :tags, through: :product_tags
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200]
    attachable.variant :medium, resize_to_limit: [400, 400]
    attachable.variant :large, resize_to_limit: [800, 800]
  end

  validates :name, presence: true
  validates :current_price, presence: true,
            numericality: { greater_than_or_equal_to: 0.01 }
  validates :stock_quantity, presence: true,
            numericality: { greater_than_or_equal_to: 0 }
  validates :sale_price, numericality: { greater_than_or_equal_to: 0.01 },
            allow_blank: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "description", "current_price", "sale_price",
     "on_sale", "stock_quantity", "category_id", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
end
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  validates :status, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id user_id status subtotal tax total created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user order_items]
  end
end

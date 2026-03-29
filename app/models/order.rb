class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  validates :status, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "user_id", "status", "subtotal", "tax", "total", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "order_items"]
  end
end

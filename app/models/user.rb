class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :province, optional: true
  has_many :orders
  has_many :addresses

  validates :email, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id email street_address city
       postal_code province_id created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[orders addresses province]
  end
end

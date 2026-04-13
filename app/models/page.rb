class Page < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :page_type, presence: true, inclusion: { in: %w[contact about] }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id title content page_type created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end

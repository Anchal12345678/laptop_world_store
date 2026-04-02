class Page < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :page_type, presence: true, inclusion: { in: ['contact', 'about'] }

  def self.ransackable_attributes(auth_object = nil)
    ["id", "title", "content", "page_type", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end

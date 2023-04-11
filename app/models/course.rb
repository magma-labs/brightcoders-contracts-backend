class Course < ApplicationRecord
  # Add the Active Storage image association
  has_one_attached :image

  # Add any necessary validations and relationships
  validates :title, presence: true
  validates :description, presence: true
end

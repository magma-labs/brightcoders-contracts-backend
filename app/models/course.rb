class Course < ApplicationRecord
  has_many :nfts
  has_one_attached :image

  validates :title, presence: true
  validates :description, presence: true
end

class Nft < ApplicationRecord
  belongs_to :student

  attr_accessor :image_temp

  validates :name, presence: true
  validates :description, presence: true
  validates :student, presence: true
  validates :image_temp, presence: true
end

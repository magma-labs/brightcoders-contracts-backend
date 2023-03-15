class Nft < ApplicationRecord
  attr_accessor :name, :description, :student, :image_temp

  validates :name, presence: true
  validates :description, presence: true
  validates :student, presence: true
	validates :image_temp, presence: true
end

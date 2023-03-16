class Student < ApplicationRecord
  has_many :nfts
  
  validates :name, presence: true
  validates :surname, presence: true
  validates :second_surname, presence: true
  validates :email, presence: true
  validates :wallet_address, presence: true
end


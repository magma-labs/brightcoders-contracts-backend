class Student < ApplicationRecord
  has_many :nfts
  has_many :nfts, dependent: :destroy
  
  validates :name, presence: true
  validates :surname, presence: true
  validates :second_surname, presence: true
  validates :email, presence: true,  uniqueness: true
  validates :wallet_address, presence: true
end

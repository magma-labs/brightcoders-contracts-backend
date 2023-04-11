class Nft < ApplicationRecord
  belongs_to :student
  belongs_to :course

  validates :name, presence: true
  validates :description, presence: true
  validates :student, presence: true
  validates :token_id, presence: true
  validates :ipfs_metadata, presence: true
  validates :ipfs_image, presence: true
  validates :course, presence: true
end

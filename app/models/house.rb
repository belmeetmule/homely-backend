class House < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations
  validates :name, presence: true
  validates :city, presence: true
  validates :image, presence: true
  validates :appartment_fee, presence: true
  validates :description, presence: true
end

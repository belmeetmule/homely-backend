class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :house
  validates :reservation_date, presence: true
end

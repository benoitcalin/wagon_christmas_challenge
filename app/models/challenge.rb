class Challenge < ApplicationRecord
  has_many :results
  has_many :users, through: :results

  validates :day, presence: true
  validates :number, presence: true
end

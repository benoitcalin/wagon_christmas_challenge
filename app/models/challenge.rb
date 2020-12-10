class Challenge < ApplicationRecord
  has_many :results
  has_many :users, through: :results
  has_many :batch_results
  has_many :batches, through: :batch_results

  validates :day, presence: true
  validates :number, presence: true
end

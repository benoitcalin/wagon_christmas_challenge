class Batch < ApplicationRecord
  has_many :users
  has_many :results, through: :users
  has_many :batch_results
  has_many :challenges, through: :batch_results

  validates :name, presence: true
end

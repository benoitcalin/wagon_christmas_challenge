class User < ApplicationRecord
  belongs_to :batch
  has_many :results
  has_many :challenges, through: :results

  validates :pseudo, presence: true, uniqueness: true
  validates :batch, presence: true
  validates :challenger_id, presence: true, uniqueness: true, length: { is: 7 }
end

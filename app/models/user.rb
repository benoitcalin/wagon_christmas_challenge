class User < ApplicationRecord
  validates :pseudo, presence: true, uniqueness: true
  validates :batch, presence: true, length: { is: 3 }
  validates :challenger_id, presence: true, uniqueness: true, length: { is: 7 }
end

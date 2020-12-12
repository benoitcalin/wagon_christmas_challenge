class User < ApplicationRecord
  belongs_to :batch

  validates :pseudo, presence: true, uniqueness: true
  validates :batch, presence: true
  validates :challenger_id, presence: true, uniqueness: true
end

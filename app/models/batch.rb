class Batch < ApplicationRecord
  has_many :users

  validates :name, presence: true

  def short_name
    return self.name.split('-')[1]
  end
end

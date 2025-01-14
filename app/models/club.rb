class Club < ApplicationRecord
  has_many :events, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
end

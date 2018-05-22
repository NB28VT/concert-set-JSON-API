class Venue < ApplicationRecord
  has_many :concerts

  validates_presence_of :name
  validates_presence_of :state

  self.per_page = 25
end

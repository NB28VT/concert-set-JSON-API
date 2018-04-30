class Venue < ApplicationRecord
  has_many :concerts
  
  validates_presence_of :name
end

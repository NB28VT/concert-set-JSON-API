class Concert < ApplicationRecord
  belongs_to :venue
  has_many :concert_sets, dependent: :destroy

  validates_presence_of :show_date
  validates_presence_of :venue
end

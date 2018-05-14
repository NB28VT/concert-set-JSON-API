class Concert < ApplicationRecord
  belongs_to :venue
  has_many :concert_sets, dependent: :destroy

  validates_presence_of :show_date
  validates_presence_of :venue

  scope :during_year, -> (year) { where(show_date: DateTime.new(year.to_i).beginning_of_year..DateTime.new(year.to_i).end_of_year) }

  # For will paginate
  self.per_page = 25
end

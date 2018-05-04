require 'rails_helper'

RSpec.describe Concert, type: :model do
  it { should belong_to(:venue) }
  it { should have_many(:concert_sets).dependent(:destroy) }

  it { should validate_presence_of(:show_date)}
  it { should validate_presence_of(:venue)}
end

require 'rails_helper'

RSpec.describe ConcertSet, type: :model do
  it { should belong_to(:concert) }
  it { should have_many(:song_performances).dependent(:destroy) }

  it { should validate_presence_of(:position_id) }
end

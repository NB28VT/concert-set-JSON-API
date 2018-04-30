require 'rails_helper'

RSpec.describe SongPerformance, type: :model do
  it { should belong_to(:concert_set)}
  it { should belong_to(:song) }

  it { should validate_presence_of(:song_id) }
  it { should validate_presence_of(:concert_set_id) }
  it { should validate_presence_of(:position_id) }
end

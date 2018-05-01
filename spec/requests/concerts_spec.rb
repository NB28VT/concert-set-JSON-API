require "rails_helper"

RSpec.describe "Concerts API", type: :request do
  let!(:concerts) { create_list(:concert, 10) }
  let(:concert) { concerts.first }
  let(:song) { create(:song) }

  # Start with show
  describe "GET /concerts/:id" do
    context "when the record exists" do
      let(:concert_sets) { create_list(:concert_sets, 3, concert: concert) }
      let(:song_performances) { concert_sets.each{ |set| create_list(:song_performance, 6, concert_set: set, song: song) } }

      before { get "/concerts/#{concert.id}"}

      it "returns a status code 200" do
        expect(response).to have_http_status(200)
      end

      # To Start
      it "returns something" do
        expect(json).not_to be_empty
      end

      it "returns concert sets in order" do
      end

      it "returns songs in each set in order" do
      end
    end

    context "when the record doesn't exist" do
      it "returns status code 404" do
      end

      it "returns a helpful message" do
      end
    end
  end
end

require "rails_helper"

RSpec.describe "Concerts API", type: :request do
  describe "GET /api/v1/concerts" do
    it "returns a list of concerts" do
      concerts = create_list(:concert, 2)
      first_concert = concerts.first

      get "/api/v1/concerts"

      expect(json["concerts"].count).to eq(2)
      expect(json["concerts"].first).to eq(
        {
          id: first_concert.id,
          show_date: first_concert.show_date,
          venue:
            {
              id: first_concert.id,
              venue: first_concert.venue
            }
        }
      )
    end

    it "returns the total number of results" do
      concerts = create_list(:concert, 10)

      get "/api/v1/concerts"

      expect(json["total_results"]).to eq(10)
    end

    it "filters concerts by year" do
      venue = create(:venue)
      create(:concert, show_date: DateTime.new(1996,8,13), venue: venue)
      create(:concert, show_date: DateTime.new(1997,11,22))

      get "/api/v1/concerts", {year: 1997}

      expect(json["concerts"].count).to eq(1)
      expect(json["concerts"].map(&:show_date)).to all(eq(1997))
    end

    it "returns the total number of results" do
    end

    it "filters results by page limit" do
    end

    it "filters results by page number" do
    end

    it "filters concerts by venue" do
    end
  end

  describe "GET /api/v1/concerts/:id" do
    context "when the record exists" do
      it "includes the concert's venue name" do
        venue = create(:venue, name: "Saratoga Performing Arts Center")
        concert = create(:concert, venue: venue)

        get "/concerts/#{concert.id}"

        expect(json["concert"]["venue"]["name"]).to eq("Saratoga Performing Arts Center")
      end

      it "returns a concert's sets in order" do
        concert = create(:concert)
        set_1 = create(:concert_set, concert: concert, position_id: 1)
        set_2 = create(:concert_set, concert: concert, position_id: 2)
        set_3 = create(:concert_set,  concert: concert, position_id: 3)

        get "/concerts/#{concert.id}"

        expect(json["sets"][0][:set_number]).to eq(1)
        expect(json["sets"][1][:set_number]).to eq(2)
        expect(json["sets"][2][:set_number]).to eq(3)
      end

      it "returns songs in each set in order" do
        concert = create(:concert)
        set_1 = create(:concert_set, concert: concert, position_id: 1)

        song_2 = create(:song, name: "Bathub Gin")
        song_performance_2 = create(:song_performance, concert_set: set_1, song: song_2, position_id: 2)

        song_1 = create(:song, name: "Roggae")
        song_performance_1 = create(:song_performance, concert_set: set_1, song: song_1, position_id: 1)

        get "/concerts/#{concert.id}"

        expect(json["sets"][0]["songs"][0]["name"]).to eq(song_1.name)
        expect(json["sets"][0]["songs"][1]["name"]).to eq(song_2.name)
      end
    end

    context "when the record doesn't exist" do
      it "returns status code 404" do
        get "/concerts/1000"

        expect(json).to have_http_status(404)
      end

      it "returns a helpful message" do
        expect(json).to match(/Couldn't find concert with id\s+\d+/)
      end
    end
  end
end

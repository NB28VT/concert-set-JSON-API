require "rails_helper"

RSpec.describe "Concerts API", type: :request do
  describe "GET /api/v1/concerts" do
    it "returns a JSON API content type" do
      get "/api/v1/concerts"
      expect(response.content_type).to eq('application/vnd.api+json')
    end

    it "returns a list of concerts" do
      concerts = create_list(:concert, 2)

      get "/api/v1/concerts"

      expect(json["data"].count).to eq(2)
      expect(json["data"][0]["type"]).to eq("concerts")
    end

    it "returns a concert's show date" do
      concert = create(:concert)

      get "/api/v1/concerts"

      expect(json["data"][0]["attributes"]["show-date"]).to eq(concert.show_date)
    end

    it "returns a link to the concert's URL" do
      concert = create(:concert)

      get "/api/v1/concerts"

      expect(json["data"][0]["links"]["self"]).to eq(api_v1_concert_url(concert))
    end

    it "returns information and a link on the concert's venue" do
      concert = create(:concert)

      get "/api/v1/concerts"

      venue = concert.venue
      venue_relationship = json["data"][0]["relationships"]["venue"]
      expect(venue_relationship["data"]["id"]).to eq(venue.id.to_s)
      expect(venue_relationship["data"]["type"]).to eq("venues")
      expect(venue_relationship["links"]["self"]).to eq(api_v1_venue_url(venue))
    end

    it "returns a link to the venue's concerts" do
      concert = create(:concert)

      get "/api/v1/concerts"

      venue = concert.venue
      venue_relationship = json["data"][0]["relationships"]["venue"]
      expect(venue_relationship["links"]["concerts"]).to eq(api_v1_venue_concerts_url(venue)
    end

    it "returns the total number of results and pages" do
      concerts = create_list(:concert, 1)

      get "/api/v1/concerts"

      expect(json["meta"]["total-results"]).to eq(1)
      expect(json["meta"]["total-pages"]).to eq(1)
    end

    it "returns 25 results per page" do
      concerts = create_list(:concert, 26)

      get "/api/v1/concerts"

      expect(json["data"].count).to eq(25)
    end

    it "paginates results" do
      concerts = create_list(:concert, 26)

      get "/api/v1/concerts", {page: 2}

      expect(json["data"].count).to eq(1)

      # TODO: more robust link tests (test link content)
      links = json["links"]
      expect(links["next"]).to eq(nil)
      expect(links["prev"]).to eq(links["first"])
      expect(links["self"]).to eq(links["last"])
    end

    it "filters concerts by year" do
      venue = create(:venue)
      create(:concert, show_date: DateTime.new(1996,8,13), venue: venue)
      create(:concert, show_date: DateTime.new(1997,11,22))

      get "/api/v1/concerts", {year: 1997}

      expect(json["data"].count).to eq(1)
      expect(json["data"].first["attributes"]["show_date"]).to match(/1997\/\d{2}\/\d{2}/)
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

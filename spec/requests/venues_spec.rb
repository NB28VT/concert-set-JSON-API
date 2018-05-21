require "rails_helper"

RSpec.describe "Venues API" do

  describe "GET /api/v1/venues/" do
    it "returns a list of venues" do
      venues = create_list(:venue, 2)

      get "/api/v1/venues"

      expect(json["data"].count).to eq(2)
      expect(json["data"][0]["type"]).to eq("venues")
      expect(json["data"][0]["id"]).to eq(venues.first.id.to_s)
    end

    it "returns 25 venues per page" do
      create_list(:venue, 26)

      get "/api/v1/venues"

      expect(json["data"].count).to eq(25)
    end

    it "returns the total number of results and pages" do
      create_list(:venue, 26)

      get "/api/v1/venues"

      expect(json["meta"]["total-results"]).to eq(26)
      expect(json["meta"]["total-pages"]).to eq(2)
    end

    it "paginates results" do
      create_list(:venue, 26)

      get "/api/v1/venues", params: {page: 2}

      expect(json["data"].count).to eq(1)

      links = json["links"]
      expect(links["next"]).to eq(nil)
      expect(links["prev"]).to eq(links["first"])
      expect(links["self"]).to eq(links["last"])
    end

    it "includes a link to the venue" do
      venue = create(:venue)

      get "/api/v1/venues"

      expect(json["data"][0]["links"]["self"]).to eq(api_v1_venue_url(venue))
    end

    it "includes the venue's name" do
      venue = create(:venue)
      get "/api/v1/venues"

      expect(json["data"][0]["attributes"]["name"]).to eq(venue.name)
    end

    it "includes the venue's state" do
      venue = create(:venue)
      get "/api/v1/venues"

      expect(json["data"][0]["attributes"]["state"]).to eq(venue.state)
    end

    it "includes a link to the venue's concerts" do
      venue = create(:venue)
      get "/api/v1/venues"

      expect(json["data"][0]["relationships"]["concerts"]["links"]["related"]).to eq(concerts_api_v1_venue_url(venue))
    end
  end

  describe "GET /api/v1/venue/:id" do
    it "includes the venue's name"
    it "includes the venue's state"
    it "includes a link to the venue's concert index"

    context "when a venue can't be found" do
      it "returns an error response" do
        # FOLLOW JSON API SPEC WITH ERROR RESPONSE
        # expect(json["errors"]).to eq({})
      end
    end


  end

  describe "GET /api/v1/venue/:id/concerts" do
    it "includes a list of a venue's concerts"
    it "paginates"
  end
end

require "rails_helper"

RSpec.describe "Concerts API", type: :request do
  describe "GET /concerts/:id" do
    context "when the record exists" do
      # it "returns a status code 200" do
      #   expect(response).to have_http_status(200)
      # end

      it "includes the concert's venue name" do
        concert = create(:concert)
        venue = create(:venue, name: "Saratoga Performing Arts Center")

        get "/concerts/#{concert.id}"

        expect(json.dig("venue", "name")).to eq("Saratoga Performing Arts Center")
      end

      it "returns a concert's sets in order" do
        concert = create(:concert)
        concert_sets = create_list(:concert_set, 3, concert: concert)

        get "/concerts/#{concert.id}"
        expect(json).to have_concerts_in_order(concert_sets)
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


  # Save for future
  # def have_concerts_in_order(concert_sets)
  #   eq concert_sets
  #   # Can use RSpec matchers here
  # end

end

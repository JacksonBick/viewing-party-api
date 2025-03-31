require 'rails_helper'

RSpec.describe "MoviesController", type: :request do
  describe "GET /api/v1/movies" do
    context "when a query is provided" do
      it "returns a list of searched movies", :vcr do
        get "/api/v1/movies?query=inception"

        expect(response).to be_successful

        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:data]).to be_an(Array)
        expect(json_response[:data].first).to have_key(:id)
        expect(json_response[:data].first).to have_key(:attributes)
        expect(json_response[:data].first[:attributes]).to have_key(:title)
      end
    end

    context "when no query is provided" do
      it "returns a list of top-rated movies", :vcr do
        get "/api/v1/movies"

        expect(response).to be_successful

        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:data]).to be_an(Array)
        expect(json_response[:data].first).to have_key(:id)
        expect(json_response[:data].first).to have_key(:attributes)
        expect(json_response[:data].first[:attributes]).to have_key(:title)
      end
    end
  end

  describe "GET /api/v1/movies/:id" do
    context "when the movie ID is valid" do
      it "returns the details of a specific movie", :vcr do
        movie_id = 278
        get "/api/v1/movies/#{movie_id}"

        expect(response).to be_successful

        json_response = JSON.parse(response.body, symbolize_names: true)

        expect(json_response[:data]).to have_key(:id)
        expect(json_response[:data]).to have_key(:type)
        expect(json_response[:data][:attributes]).to have_key(:title)
        expect(json_response[:data][:attributes]).to have_key(:release_year)
        expect(json_response[:data][:attributes]).to have_key(:vote_average)
        expect(json_response[:data][:attributes]).to have_key(:runtime)
        expect(json_response[:data][:attributes]).to have_key(:genres)
        expect(json_response[:data][:attributes]).to have_key(:summary)
        expect(json_response[:data][:attributes]).to have_key(:cast)
        expect(json_response[:data][:attributes]).to have_key(:total_reviews)
        expect(json_response[:data][:attributes]).to have_key(:reviews)
      end
    end
  end
end
require "rails_helper"

RSpec.describe "Movies Endpoint", type: :request do
  describe "GET #show" do
    context "when the external API request is successful" do
      it "returns a successful response with movie data" do
        movie_name = "Inception"

        movie_search_response = File.read(Rails.root.join('spec', 'fixtures', 'movie_query.json'))
        
        stub_request(:get, "https://api.themoviedb.org/search/movie?query=Inception").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>"Bearer #{ENV['tmbd_token']}",
          'User-Agent'=>'Faraday v2.10.1'
           }).
         to_return(status: 200, body: movie_search_response, headers: {})
     
        get "/api/v1/movies/#{movie_name}"
        expect(response).to be_successful
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:data]).to be_an(Array)
        expect(json[:data].first[:title]).to eq("Inception")

      end
    end
  end
end
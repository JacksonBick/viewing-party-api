require 'rails_helper'

RSpec.describe "viewing party controller", type: :request do
  describe "POST /api/v1/viewing_parties" do
    before do
      @user = User.create!(name: "Tom", username: "tommy", password: "test123")
    end

    it "creates a new viewing party" do
      viewing_party_params = {
        name: "Inception Viewing",
        start_time: "2025-03-31T20:00:00Z",
        end_time: "2025-03-31T22:30:00Z",
        movie_id: 1, 
        movie_title: "Inception",
        invitees: [@user.id]
      }

      post "/api/v1/viewing_parties", params: { user_id: @user.id, **viewing_party_params }, as: :json

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:attributes][:name]).to eq(viewing_party_params[:name])
      expect(json[:data][:attributes][:movie_title]).to eq(viewing_party_params[:movie_title])

      expect(json[:data][:attributes][:invitees].count).to eq(1)
      expect(json[:data][:attributes][:invitees].first[:id]).to eq(@user.id)
      expect(json[:data][:attributes][:invitees].first[:name]).to eq(@user.name)
      expect(json[:data][:attributes][:invitees].first[:username]).to eq(@user.username)
    end
  end

  describe "POST /api/v1/viewing_parties/:viewing_party_id/invite_user" do
    before do
      @user = User.create!(name: "Tom", username: "tommy", password: "test123")
      @viewing_party = ViewingParty.create!(
        name: "Inception Viewing",
        start_time: "2025-03-31T20:00:00Z",
        end_time: "2025-03-31T22:30:00Z",
        movie_id: 1, 
        movie_title: "Inception",
        host_id: @user.id
      )
      @invitee = User.create!(name: "Oprah", username: "oprah", password: "password123")
    end

    it "adds the user to the viewing party's invitees" do
      post "/api/v1/viewing_parties/#{@viewing_party.id}/invite_user", params: { invitee_user_id: @invitee.id }, as: :json

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:attributes][:invitees].count).to eq(1) 

      invitee = json[:data][:attributes][:invitees].find { |i| i[:id] == @invitee.id }
      expect(invitee).not_to be_nil
      expect(invitee[:name]).to eq(@invitee.name)
      expect(invitee[:username]).to eq(@invitee.username)
    end

    it "does not duplicate the invitee in the invitees list if already invited" do
      @viewing_party.users << @invitee

      post "/api/v1/viewing_parties/#{@viewing_party.id}/invite_user", params: { invitee_user_id: @invitee.id }, as: :json

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:attributes][:invitees].count).to eq(2)

      invitee = json[:data][:attributes][:invitees].find { |i| i[:id] == @invitee.id }
      expect(invitee).not_to be_nil
      expect(invitee[:name]).to eq(@invitee.name)
      expect(invitee[:username]).to eq(@invitee.username)
    end
  end
end
class Api::V1::ViewingPartiesController < ApplicationController
  def create
    viewing_party_params = params.permit(:name, :start_time, :end_time, :movie_id, :movie_title, :invitees)
    
    
    host = User.find_by(id: params[:user_id])


    viewing_party = ViewingParty.new(
      name: viewing_party_params[:name],
      start_time: viewing_party_params[:start_time],
      end_time: viewing_party_params[:end_time],
      movie_id: viewing_party_params[:movie_id],
      movie_title: viewing_party_params[:movie_title],
      host_id: host.id
    )

    if viewing_party.save
      params[:invitees].each do |user_id|
        user = User.find(user_id)
        viewing_party.users << user
      end
      render json: ViewingPartySerializer.new(viewing_party).serializable_hash, status: :created
    else
      render json: { error: "Unable to create Viewing Party" }, status: :unprocessable_entity
    end
  end

  def invite_user
    viewing_party = ViewingParty.find(params[:viewing_party_id])
    user = User.find(params[:invitee_user_id]) 

    viewing_party.users << user

    if viewing_party.save
      render json: ViewingPartySerializer.new(viewing_party).serializable_hash, status: :ok
    else
      render json: { error: "Unable to invite user" }, status: :unprocessable_entity
    end
  end
end
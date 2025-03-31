class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :username, :api_key

  attribute :viewing_parties_hosted do |user|
    user.hosted_viewing_parties.map do |party|
      {
        id: party.id,
        name: party.name,
        start_time: party.start_time,
        end_time: party.end_time,
        movie_id: party.movie_id,
        movie_title: party.movie_title,
        host_id: party.host_id
      }
    end
  end

  attribute :viewing_parties_invited do |user|
    user.viewing_parties.map do |party|
      {
        id: party.id,
        name: party.name,
        start_time: party.start_time,
        end_time: party.end_time,
        movie_id: party.movie_id,
        movie_title: party.movie_title,
        host_id: party.host_id
      }
    end
  end
  
end


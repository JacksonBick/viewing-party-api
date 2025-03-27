class MovieSerializer < ActiveModel::Serializer
  include JSONAPI::Serializer
  attributes :id, :type, :title, :vote_average

  def id
    object['id'].to_s 
  end

  def type
    'movie'
  end

  def title
    object['title']
  end

  def vote_average
    object['vote_average']
  end
end
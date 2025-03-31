class Movie
  attr_reader :id, :title, :vote_average
  def initialize(movie)
    @id = movie[:id].to_s
    @title = movie[:title]
    @vote_average = movie[:vote_average]
  end

  def movie_hash
    {
      id: @id,
      type: 'movie',
      attributes: {
        title: @title,
        vote_average: @vote_average
      }
    }
  end
end

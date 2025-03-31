class TopRatedFacade
  
  def top_rated_movie_data
    gateway.top_rated_movies
  end

  def gateway
    TmbdGateway.new
  end

  def top_movies
    
    top_rated_movie_data[:results].each do |movie|
      Movie.new(movie)
    end
  end
end
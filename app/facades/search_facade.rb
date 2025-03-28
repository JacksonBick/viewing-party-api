class SearchFacade

  def search_movie_data(title)
    gateway.movie_search(title)
  end

  def gateway
    TmbdGateway.new
  end

  def searched_movies(title)
    search_movie_data(title)[:results].each do |movie|
      Movie.new(movie)
    end
  end
end
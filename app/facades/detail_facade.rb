class DetailFacade

  def movie_detail_data(movie_id)
    gateway.movie_details(movie_id)
  end

  def gateway
    TmbdGateway.new
  end

  def found_details(movie_id)
    movie_details = movie_detail_data(movie_id)

    DetailedMovie.new(movie_details)
  end
end
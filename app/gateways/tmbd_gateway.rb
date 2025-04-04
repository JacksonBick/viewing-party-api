class TmbdGateway
  
  def top_rated_movies
    
    get_url("movie/top_rated")
  end

  def movie_search(title)
    get_url("search/movie?query=#{title}")
  end

  def movie_details(movie_id)
    get_url("movie/#{movie_id}?append_to_response=credits,reviews")
  end

  def get_url(url)
    response = conn.get(url)
    
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
      Faraday.new(url: 'https://api.themoviedb.org/3') do |faraday|
        faraday.headers['Authorization'] = "Bearer #{ENV['tmbd_token']}"
      end
  end
end
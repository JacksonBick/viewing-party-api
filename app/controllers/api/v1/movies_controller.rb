class Api::V1::MoviesController < ApplicationController
  def show
    movie_name = params[:movie_name]

    conn = Faraday.new(url: 'https://api.themoviedb.org/3') do |faraday|
      faraday.headers['Authorization'] = "Bearer #{ENV["tmbd_token"]}"
    end

    response = conn.get('/search/movie', { query: movie_name })

    movie_data = JSON.parse(response.body)

    if response.status == 200
      render json: { data: movie_data['results'].take(20) }
    end
  end
end

class Api::V1::MoviesController < ApplicationController
  def show
    movie_name = params[:movie_name]

    conn = Faraday.new(url: 'https://api.themoviedb.org/3') do |faraday|
      faraday.headers['Authorization'] = "Bearer #{ENV["tmbd_token"]}"
    end

    response = conn.get('/search/movie', { query: movie_name })
    Rails.logger.debug("API Response: #{response.body}")

    if response.status == 200
      movie_data = JSON.parse(response.body)

      formatted_data = movie_data['results'].map do |movie|
        MovieSerializer.new(movie).serializable_hash
      end

        render json: { data: formatted_data.take(20)}
    end
  end
end

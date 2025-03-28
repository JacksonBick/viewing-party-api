class Api::V1::MoviesController < ApplicationController
  def index
    if params[:query].present?
      search_movies_data = SearchFacade.new.searched_movies(params[:query])

      searched_movies = search_movies_data.map { |search_movie_data| Movie.new(search_movie_data) }

      serialized_movies = MovieSerializer.new(searched_movies).serializable_hash

      render json: { data: serialized_movies[:data] }
    else
      top_movies_data = TopRatedFacade.new.top_movies 

      top_movies = top_movies_data.map { |top_movie_data| Movie.new(top_movie_data) }

      serialized_movies = MovieSerializer.new(top_movies).serializable_hash

      render json: { data: serialized_movies[:data] }
    end
  end
end
class DetailedMovie
  attr_reader :id, :title, :release_year, :vote_average, :runtime, :genres, :summary, :cast, :total_reviews, :reviews

  def initialize(movie_data)
    @id = movie_data[:id]
    @title = movie_data[:title]
    @release_year = movie_data[:release_date].split('-').first
    @vote_average = movie_data[:vote_average]
    @runtime = format_runtime(movie_data[:runtime])
    @genres = movie_data[:genres].map { |genre| genre[:name] }
    @summary = movie_data[:overview]
    @cast = format_cast(movie_data[:credits][:cast])
    @total_reviews = movie_data[:reviews][:total_results]
    @reviews = format_reviews(movie_data[:reviews][:results])
  end

  def attributes
    {
      title: @title,
      release_year: @release_year,
      vote_average: @vote_average,
      runtime: @runtime,
      genres: @genres,
      summary: @summary,
      cast: @cast,
      total_reviews: @total_reviews,
      reviews: @reviews
    }
  end
  private

  def format_runtime(runtime)
    hours = runtime / 60
    minutes = runtime % 60
    "#{hours} hours, #{minutes} minutes"
  end

  def format_cast(cast)
    cast.take(10).map do |actor|
      {
        character: actor[:character],
        actor: actor[:name]
      }
    end
  end

  def format_reviews(reviews)
    reviews.take(5).map do |review|
      {
        author: review[:author],
        review: review[:content]
      }
    end
  end
end
require_relative("../db/sql_runner")

class Movie

  attr_reader :id, :budget
  attr_accessor :title, :genre, :budget

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @genre = options['genre']
    @budget = options['budget']
  end

  # def save()
  #   sql = "INSERT INTO movies (title, genre, budget)
  #          VALUES ($1, $2, $3)
  #          RETURNING id"
  #   values = [@title, @genre, @budget]
  #   movie = SqlRunner.run(sql, values).first
  #   @id = movie['id'].to_i
  # end

  def save
    sql = "INSERT INTO movies (title, genre, budget)
           VALUES ($1, $2, $3)
           RETURNING id"
    values = [@title, @genre, @budget]
    casting = SqlRunner.run(sql, values).first
    @id = casting['id'].to_i
  end

  def Movie.delete_all()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql, [])
  end

  def Movie.all()
    sql = "SELECT * FROM movies"
    movies = SqlRunner.run(sql)
    result = movies.map {|movie| Movie.new(movie)}
    return result
  end

  def stars()
    sql = "SELECT stars.* FROM stars
           INNER JOIN castings
           ON stars.id = castings.star_id
           WHERE castings.movie_id = $1"
    values = [@id]
    stars = SqlRunner.run(sql, values)
    return stars.map {|star_hash| Star.new(star_hash)}
  end
end

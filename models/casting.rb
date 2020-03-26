require_relative("../db/sql_runner")

class Casting

  attr_accessor :movie_id, :star_id, :fee
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @movie_id = options['movie_id']
    @star_id = options['star_id']
    @fee = options['fee']
  end

  def save()
    sql = "INSERT INTO castings (movie_id, star_id, fee)
           VALUES ($1, $2, $3)
           RETURNING id"
    values = [@movie_id, @star_id, @fee]
    casting = SqlRunner.run(sql, values).first
    @id = casting['id'].to_i
  end

  def Casting.delete_all()
    sql = "SELECT FROM castings"
    SqlRunner.run(sql, [])
  end

  def Casting.all()
    sql = "SELECT * FROM castings"
    castings = SqlRunner.run(sql)
    result = castings.map {|casting| Casting.new(casting)}
    return result
  end

  def star()
    sql = "SELECT * FROM stars WHERE id =$1"
    values = [@star_id]
    star_hash = SqlRunner.run(sql, values).first()
    return Star.new(star_hash)
  end

  def movie()
    sql = "SELECT * FROM movies WHERE id = $1"
    values = [@movie_id]
    movie_hash = SqlRunner.run(sql, values).first()
    return Movie.new(movie_hash)
  end
end

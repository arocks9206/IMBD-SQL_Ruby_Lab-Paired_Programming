require_relative('models/star')
require_relative('models/movie')
require_relative('models/casting')

require('pry')

Casting.delete_all()
Movie.delete_all()
Star.delete_all()

movie1 = Movie.new({'title' => 'Avengers',
                    'genre' => 'Action',
                    'budget' => 10000000})
movie1.save()

movie2 = Movie.new({'title' => "Moonrise Kingdom",
                    'genre' => "Indie",
                    'budget' => 15000000})
movie2.save()

star1 = Star.new({'first_name' => 'Scarlett',
                  'last_name' => 'Johansson'})

star1.save()

star2 = Star.new({'first_name' => "Bill",
                  'last_name' => "Murray"})
star2.save()

casting1 = Casting.new({'star_id' => star1.id, 'movie_id' => movie1.id, 'fee' => 1000000})
casting1.save()

casting2 = Casting.new({'star_id' => star2.id, 'movie_id' =>movie2.id, 'fee' => 2000000})
casting2.save()

binding.pry
nil

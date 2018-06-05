require 'rest-client'
require 'json'
require 'pry'


def first_page(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  movies = get_character_movies_from_api(character, character_hash)
  binding.pry
end


def get_character_movies_from_api(character, character_hash)
  #make the web request
  
    films = []

   character_hash["results"].map do |character_name|
      if character_name["name"] == character
        films = character_name["films"]
      end
    end
    if films.length == 0
          next_page = RestClient.get(character_hash["next"])
          json = JSON.parse(next_page)
          get_character_movies_from_api(character, json)
    end
    films
    parse_character_movies(films)
  end

  
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.


def parse_character_movies(films_array)
  # some iteration magic and puts out the movies in a nice list
        films_array.each do |film_urls|
          film = RestClient.get(film_urls)
          json = JSON.parse(film)
          puts json["title"]
        end

        
    # binding.pry

end

def show_character_movies(character)
  films_hash = first_page(character)
  # parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

# get_character_movies_from_api("Luke Skywalker")

# show_character_movies("Luke Skywalker")


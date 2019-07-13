require 'pry'

class MusicLibraryController
  extend Concerns::Findable


  def initialize(path = "./db/mp3s")
    new_importer = MusicImporter.new(path)
    new_importer.import

  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    user_input = gets.strip.downcase
    case user_input
    when "list songs"
      list_songs
    when "list artists"
      list_artists
    when "list genres"
      list_genres
    when "list artist"
      list_songs_by_artist
    when "list genre"
      list_songs_by_genre
    when "play song"
      play_song
    when "exit"
      'exit'
    else
      call
    end
  end

  def list_songs
    songs = Song.all.sort_by { |song| song.name }

    songs.each_with_index { |song,index| puts "#{songs.index(song) + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists

    #Artist.all.each_with_index { |artist, index| puts "#{index + 1}. #{artist.name}"}
  end

  def list_genres
    #Genre.all.each { |genre| puts genre.name }
  end

  def play_song

  end

  def list_artist

  end

  def list_genre

  end

end

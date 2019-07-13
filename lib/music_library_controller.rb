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
    songs = Song.all.uniq.sort_by { |song| song.name }
    songs.each.with_index(1) { |song,index| puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}" }
  end

  def list_artists
    artists = Artist.all.uniq.sort_by { |artist| artist.name }
    artists.each.with_index(1) { |artist,index| puts "#{index}. #{artist.name}" }
  end

  def list_genres
    genres = Genre.all.uniq.sort_by { |genre| genre.name }
    genres.each.with_index(1) { |genre,index| puts "#{index}. #{genre.name}" }
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    response = gets.strip

    if response = Artist.find_by_name(response)
      sorted_artists = response.songs.sort { |a,b| a.name <=> b.name}
      sorted_artists.each.with_index(1) do |song, index|
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    end


  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    response = gets.strip

    if response = Genre.find_by_name(response)
      sorted_genres = response.songs.sort { |a,b| a.name <=> b.name}
      sorted_genres.each.with_index(1) do |song, index|
        puts "#{index}. #{song.artist.name} - #{song.name}"
      end
    end
  end


  def play_song
    puts "Which song number would you like to play?"
    response = gets.strip.to_i

    if (response < Song.all.length && response > 0)
      all_songs = Song.all.uniq.sort_by { |song| song.name }
      puts "Playing #{all_songs[response - 1].name} by #{all_songs[response - 1].artist.name}" unless all_songs[response - 1] == nil
    end
  end

end

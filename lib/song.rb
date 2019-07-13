class Song
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist != nil
    self.genre = genre if genre != nil
  end

  def artist=(artist)
    @artist = artist
    self.artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    self.genre.add_song(self)
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    instance = self.new(name)
    instance.save
    instance
  end

  def save
    @@all << self
  end

  def self.find_by_name(name)
    @@all.detect { |song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) ? find_by_name(name) : create(name)
  end

  def self.new_from_filename(file_name)
   parsed_file = file_name.chomp(".mp3").split(" - ")
   new_song = self.find_or_create_by_name(parsed_file[1])
   new_song.artist = Artist.find_or_create_by_name(parsed_file[0])
   new_song.genre = Genre.find_or_create_by_name(parsed_file[2])
   new_song
 end

 def self.create_from_filename(file_name)
    new_song = self.new_from_filename(file_name)
    new_song.save
    new_song
  end

end

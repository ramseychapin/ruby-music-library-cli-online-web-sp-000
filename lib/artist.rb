class Artist
  extend Concerns::Findable
  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
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

  def songs
    @songs
  end

  def add_song(song)
    song.artist = self if song.artist == nil
    self.songs << song if self.songs.include?(song) == false
  end

  def genres
    self.songs.collect {|song| song.genre}.uniq
  end

end

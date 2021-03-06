require_relative "station.rb"

class Route
  @@all = {}

  attr_reader :stations, :name

  def self.all
    @@all
  end

  def initialize(from, to)
    @name = "#{from.name}-#{to.name}"
    @stations = [from, to]
    @@all[self] = self.stations
  end

  def add(station)
    return if @stations.include?(station)
    @stations.insert(-2, station)
  end

  def remove(station)
    return if end_station?(station)
    @stations.delete(station)
  end

  private

  def end_station?(station)
    station == @stations.first || station == @stations.last
  end
end

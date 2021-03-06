class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    @trains << train
  end

  def trains_by(type)
    @trains.find_all{ |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end

class Route
  attr_reader :stations

  def initialize(from, to)
    @name = "#{from.name}-#{to.name}"
    @stations = [from, to]
  end

  def add(station)
    @stations.insert(-2, station)
  end

  def remove(station)
    if station != @stations.first && station != @stations.last
      @stations.delete(station)
    end
  end
end

class Train
  attr_reader :wagons, :speed, :type, :route

  def initialize(number, type, wagons = 0)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def move_forward
    if next_station
      current_station.send_train(self)
      next_station.accept_train(self)
      @station_index += 1
    end
  end

  def move_backward
    if previous_station
      current_station.send_train(self)
      previous_station.accept_train(self)
      @station_index -= 1
    end
  end

  def route=(route)
    @route = route
    @station_index = 0
  end

  def current_station
    @route.stations[@station_index]
  end

  def next_station
     @route.stations[@station_index + 1]
  end

  def previous_station
    @route.stations[@station_index - 1] if @station_index > 0
  end

  def go
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def hook
    @wagons += 1 if speed.zero?
  end

  def unhook
    @wagons -= 1 if wagons > 0 && speed.zero?
  end
end

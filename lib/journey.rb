require_relative 'oystercard'

class Journey

  PENALTY_FARE = 6
  MIN_FARE = 1

  attr_reader :entry_station, :exit_station

  def initialize(entry_station: entry_station, exit_station: exit_station)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def complete?
    !exit_station.nil?
  end

  def fare
    return MIN_FARE unless !complete?
    PENALTY_FARE
  end

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
    self
  end

end

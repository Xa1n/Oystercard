require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :trips

  LIMIT = 90
  MIN = 1

  def initialize
    @balance = 0
    @trips = []
  end

  def top_up(amount)
    raise "Cannot add #{amount} to card. #{LIMIT} maximum limit exceeded" if amount > LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Minimum balance not met" if @balance < MIN

    @trip = {}
    @trip[:Entry] = station
  end

  def touch_out(station)
    deduct(MIN)
    @trip[:Exit] = station
    store
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def store
    @trips << @trip
  end

  # def exceed?
  #   top_up(amount) > LIMIT
  # end
end

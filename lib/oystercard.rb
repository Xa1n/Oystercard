require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :journey_history, :journey

  LIMIT = 90
  MIN = 1

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    raise "Cannot add #{amount} to card. #{LIMIT} maximum limit exceeded" if amount > LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Minimum balance not met" if @balance < MIN

    @journey = Journey.new
    @journey.entry_station = station

  end

  def touch_out(station)
    deduct(MIN)

    @journey.exit_station = station

    store
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def store
    @journey_history << @journey.log
  end

  # def exceed?
  #   top_up(amount) > LIMIT
  # end
end

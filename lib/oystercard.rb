class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :trips

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

    @entry_station = station
    @trip = {}
    @trip[:Entry] = station

  end

  def touch_out(station)
    deduct(MIN)
    @entry_station = nil
    @trip[:Exit] = station
    @trips << @trip
  end

  def in_journey?
    !!entry_station
  end


  private

  def deduct(fare)
    @balance -= fare
  end

  # def exceed?
  #   top_up(amount) > LIMIT
  # end
end

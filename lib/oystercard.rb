class Oystercard

  attr_reader :balance, :entry_station

  LIMIT = 90
  MIN = 1

  def initialize
    @balance = 0
    @entry_station = entry_station
  end

  def top_up(amount)
    raise "Cannot add #{amount} to card. #{LIMIT} maximum limit exceeded" if amount > LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Minimum balance not met" if @balance < MIN
    @entry_station = station
  end

  def touch_out
    deduct(MIN)
    @entry_station = nil
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

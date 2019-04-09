class Oystercard

  attr_reader :balance, :state, :entry_station

  LIMIT = 90
  MIN = 1

  def initialize
    @balance = 0
    @state = false
    @entry_station = station
  end

  def top_up(amount)
    raise "Cannot add #{amount} to card. #{LIMIT} maximum limit exceeded" if amount > LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Minimum balance not met" if @balance < MIN
    @state = true
  end

  def touch_out
    deduct(MIN)
    @state = false
  end

  def in_journey?
    @state == true
  end


  private

  def deduct(fare)
    @balance -= fare
  end

  # def exceed?
  #   top_up(amount) > LIMIT
  # end
end

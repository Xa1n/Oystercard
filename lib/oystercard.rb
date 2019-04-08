class Oystercard

  attr_reader :balance, :state

  LIMIT = 90

  def initialize
    @balance = 0
    @state = false
  end

  def top_up(amount)
    raise "Cannot add #{amount} to card. #{LIMIT} maximum limit exceeded" if amount > LIMIT
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    @state = true
  end

  def touch_out
    @state = false
  end

  def in_journey?
    @state == true
  end

  #
  # def exceed?
  #   amount > LIMIT
  # end
end

class Oystercard

  attr_reader :balance

  LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Cannot add #{amount} to card. #{LIMIT} maximum limit exceeded" if amount > LIMIT
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  # private
  #
  # def exceed?
  #   amount > LIMIT
  # end
end

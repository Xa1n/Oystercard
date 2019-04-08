require 'oystercard'

RSpec.describe Oystercard do

  it "initializes card with default balance" do
    expect(subject.balance).to eq 0
  end

  it "increments the balance" do
    amount = 10
     expect { subject.top_up(amount) }.to change { subject.balance }.from(0).to(10)
  end

end

require 'oystercard'

RSpec.describe Oystercard do

  it "initializes card with default balance" do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it "increments the balance" do
      amount = 10
       expect { subject.top_up(amount) }.to change { subject.balance }.from(0).to(10)
    end

    it "prevents top_up to go over the limit" do
      amount = 100
      LIMIT = 90
      expect { subject.top_up(amount)}.to raise_error("Cannot add #{amount} to card. #{LIMIT} maximum limit exceeded")
    end
  end

  describe "#deduct" do
    it "deducts fare from balance" do
      subject.top_up(20)
      fare = 10
      expect {subject.deduct(fare)}.to change { subject.balance }.from(20).to(10)
    end
  end
end

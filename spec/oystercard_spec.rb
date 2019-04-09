require 'oystercard'

RSpec.describe Oystercard do

  let(:station) { double :station}

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

  # describe "#deduct" do
  #   it "deducts fare from balance" do
  #     subject.top_up(20)
  #     fare = 10
  #     expect {subject.deduct(fare)}.to change { subject.balance }.from(20).to(10)
  #   end
  # end

  describe "#touch_in" do
    it "begins the journey" do
      subject.instance_variable_set(:@balance, Oystercard::MIN)
      subject.touch_in(station)
      expect(subject.in_journey?).to be true
    end

    it "prevents touch_in from working if minimum balance isn't met" do
      expect {subject.touch_in(station) }.to raise_error "Minimum balance not met"
    end

    it "remembers entry station" do
      subject.instance_variable_set(:@balance, Oystercard::MIN)
      allow(subject).to receive(:entry_station) { station }
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end
  end

  describe "#touch_out" do
    it "ends the journey" do
      subject.instance_variable_set(:@balance, Oystercard::MIN)
      subject.touch_in(station)
      expect { subject.touch_out }.to change { subject.in_journey?}.from(true).to(false)
    end

    it "deducts fare from balance" do
      subject.instance_variable_set(:@balance, Oystercard::MIN)
      expect { subject.touch_out }.to change {subject.balance}.by(-Oystercard::MIN)
    end

    it "forgets entry station" do
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end
  end

  describe "#in_journey" do
    it "tests if not in_journey" do
      subject.instance_variable_set(:@balance, Oystercard::MIN)
      expect(subject.in_journey?).to be false
    end

    it "tests if in_journey" do
      subject.instance_variable_set(:@balance, Oystercard::MIN)
      subject.touch_in(station)
      expect(subject.in_journey?).to be true
    end
  end
end

require 'oystercard'

RSpec.describe Oystercard do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  describe '#trips' do
    let(:trip) { {Entry: entry_station, Exit: exit_station} }

    it 'stores a trip' do
      subject.instance_variable_set(:@balance, Oystercard::MIN)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.trips).to include trip
    end
  end

  it "initializes card with default balance and an empty list of journeys" do
    expect(subject.balance).to eq 0
    expect(subject.trips).to be_empty
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

  # describe "#touch_in" do
  #   it "begins the journey" do
  #     subject.instance_variable_set(:@balance, Oystercard::MIN)
  #     subject.touch_in(entry_station)
  #     expect(subject.in_journey?).to be true
  #   end

    it "prevents touch_in from working if minimum balance isn't met" do
      expect {subject.touch_in(entry_station) }.to raise_error "Minimum balance not met"
    end

  #   it "remembers entry station" do
  #     subject.instance_variable_set(:@balance, Oystercard::MIN)
  #     subject.touch_in(entry_station)
  #     expect(subject.entry_station).to eq(entry_station)
  #   end
  # end

  describe "#touch_out" do
    # it "ends the journey" do
    #   subject.instance_variable_set(:@balance, Oystercard::MIN)
    #   subject.touch_in(entry_station)
    #   expect { subject.touch_out(exit_station) }.to change { subject.in_journey?}.from(true).to(false)
    # end

    it "deducts fare from balance" do
      subject.instance_variable_set(:@balance, Oystercard::MIN)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change {subject.balance}.by(-Oystercard::MIN)
    end

    # it "forgets entry station" do
    #   subject.instance_variable_set(:@balance, Oystercard::MIN)
    #   subject.touch_in(entry_station)
    #   subject.touch_out(exit_station)
    #   expect(subject.entry_station).to eq nil
    # end

    # it "remembers exit station" do
    #   subject.instance_variable_set(:@balance, Oystercard::MIN)
    #   subject.touch_in(entry_station)
    #   subject.touch_out(exit_station)
    #   expect(subject.exit_station).to eq(exit_station)
    # end
  end

  describe "#in_journey" do
    # it "tests if not in_journey" do
    #   subject.instance_variable_set(:@balance, Oystercard::MIN)
    #   expect(subject.in_journey?).to be false
    # end

    # it "tests if in_journey" do
    #   subject.instance_variable_set(:@balance, Oystercard::MIN)
    #   subject.touch_in(entry_station)
    #   expect(subject.in_journey?).to be true
    # end
  end
end

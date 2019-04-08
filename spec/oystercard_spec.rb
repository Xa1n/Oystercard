require 'oystercard'

RSpec.describe Oystercard do

  it "initializes card with default balance" do
    expect(subject.balance).to eq 0
  end

end

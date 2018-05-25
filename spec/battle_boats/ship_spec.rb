require "battle_boats/ship"

RSpec.describe BattleBoats::Ship do
  describe "#name" do
    it "returns the name" do
      name = "Patrol Boat"
      ship = BattleBoats::Ship.new(name: name, length: nil)

      expect(ship.name).to eq name
    end
  end
  describe "#length" do
    it "returns the length" do
      length = 10
      ship = BattleBoats::Ship.new(name: nil, length: length)

      expect(ship.length).to eq length
    end
  end
  describe "#symbol" do
    it "returns a symbol of a ship" do
      symbol = "P"
      ship = BattleBoats::Ship.new(name: nil, length: nil, symbol: symbol)

      expect(ship.symbol).to include symbol
    end
  end
  describe "#to_ansi" do
    it "returns a ANSI colorized symbol of a ship" do
      ship = BattleBoats::Ship.new(name: nil, length: nil)

      expect(ship.to_ansi).to include ship.symbol
    end
  end
  describe "#empty?" do
    it "returns false" do
      ship = BattleBoats::Ship.new(name: nil, length: nil)

      expect(ship).to_not be_empty
    end
  end
  describe "#hit" do
    it "increases the hit_count by one" do
      ship = BattleBoats::Ship.new(name: nil, length: 2)

      expect(ship.instance_variable_get(:@hits)).to eq 0

      ship.hit

      expect(ship.instance_variable_get(:@hits)).to eq 1
    end
  end
  describe "#sunk?" do
    context "when the ship has not been completely hit" do
      it "returns false" do
        ship = BattleBoats::Ship.new(name: nil, length: 2)

        ship.hit

        expect(ship.sunk?).to eq false
      end
    end
    context "when the ship has been completely hit" do
      it "returns true" do
        ship = BattleBoats::Ship.new(name: nil, length: 2)

        ship.hit
        ship.hit

        expect(ship.sunk?).to eq true
      end
    end
  end
end

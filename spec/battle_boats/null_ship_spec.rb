require "battle_boats/null_ship"

RSpec.describe BattleBoats::NullShip do
  describe "#length" do
    it "returns the length" do
      ship = BattleBoats::NullShip.new

      expect(ship.length).to eq 1
    end
  end
  describe "#symbol" do
    it "returns the symbol of a null ship" do
      ship = BattleBoats::NullShip.new

      expect(ship.symbol).to include "X"
    end
  end
  describe "#empty?" do
    it "returns true" do
      ship = BattleBoats::NullShip.new

      expect(ship).to be_empty
    end
  end
  describe "#hit" do
    it "returns nil" do
      ship = BattleBoats::NullShip.new

      expect(ship.hit).to be_nil
    end
  end
  describe "#sunk?" do
    it "returns nil" do
      ship = BattleBoats::NullShip.new

      expect(ship.sunk?).to be_nil
    end
  end
end

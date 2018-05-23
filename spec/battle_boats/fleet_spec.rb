require "battle_boats/fleet"
require "battle_boats/ship"

RSpec.describe BattleBoats::Fleet do
  describe "#ships" do
    it "returns an array of ships" do
      fleet = BattleBoats::Fleet.new
      result = fleet.ships
      expect(result).to be_an Array
      expect(result).to all be_instance_of BattleBoats::Ship
    end
  end
end

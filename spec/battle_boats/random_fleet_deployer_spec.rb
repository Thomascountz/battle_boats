require "battle_boats/random_fleet_deployer"
require "battle_boats/fleet"
require "battle_boats/board"

RSpec.describe BattleBoats::RandomFleetDeployer do
  describe "#deploy" do
    it "returns a board of randomly placed ships in the play area" do
      fleet = BattleBoats::Fleet.new
      expected_cells_with_ships = fleet.ships.sum(&:length)
      random_fleet_deployer = BattleBoats::RandomFleetDeployer.new

      board = random_fleet_deployer.deploy(fleet)

      cells_with_ships = board.play_area.flatten.count(&:occupied?)

      expect(cells_with_ships).to eq expected_cells_with_ships
    end
  end
end

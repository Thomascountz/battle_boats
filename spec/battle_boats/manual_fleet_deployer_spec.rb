require "battle_boats/manual_fleet_deployer"
require "battle_boats/console_ui"
require "battle_boats/fleet"
require "battle_boats/board"
require "battle_boats/coordinate"

RSpec.describe BattleBoats::ManualFleetDeployer do
  let(:interface) { instance_double(BattleBoats::ConsoleUI) }
  let(:fleet) { instance_double(BattleBoats::Fleet) }
  subject(:manual_fleet_deployer) { described_class.new(interface: interface) }

  describe "#deploy" do
    context "when successfully placing a ship horizontally" do
      it "returns a board of user-placed ships in the play area" do
        ship = BattleBoats::Ship.new(name: "foo", length: 1, symbol: "foo")
        ships = [ship]
        coordinate = BattleBoats::Coordinate.new(row: 0, column: 0)
        orientation = :horizontal

        allow(fleet).to receive(:ships).and_return ships
        allow(interface).to receive(:display_board)
        allow(interface).to receive(:display_ship_data).with ship
        allow(interface).to receive(:prompt_ship_placement_coordinate).with ship
        allow(interface).to receive(:get_coordinate).and_return coordinate
        allow(interface).to receive(:prompt_ship_placement_orientation).with ship
        allow(interface).to receive(:get_orientation).and_return orientation

        board = manual_fleet_deployer.deploy(fleet)

        expected_cells_with_ships = 1

        cells_with_ships = board.play_area.flatten.count(&:occupied?)

        expect(cells_with_ships).to eq expected_cells_with_ships
      end
    end
    context "when successfully placing a ship vertically" do
      it "returns a board of user-placed ships in the play area" do
        ship = BattleBoats::Ship.new(name: "foo", length: 1, symbol: "foo")
        ships = [ship]
        coordinate = BattleBoats::Coordinate.new(row: 0, column: 0)
        orientation = :vertical

        allow(fleet).to receive(:ships).and_return ships
        allow(interface).to receive(:display_board)
        allow(interface).to receive(:display_ship_data).with ship
        allow(interface).to receive(:prompt_ship_placement_coordinate).with ship
        allow(interface).to receive(:get_coordinate).and_return coordinate
        allow(interface).to receive(:prompt_ship_placement_orientation).with ship
        allow(interface).to receive(:get_orientation).and_return orientation

        board = manual_fleet_deployer.deploy(fleet)

        expected_cells_with_ships = 1

        cells_with_ships = board.play_area.flatten.count(&:occupied?)

        expect(cells_with_ships).to eq expected_cells_with_ships
      end
    end
  end
end

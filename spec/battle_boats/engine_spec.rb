require "battle_boats/engine"
require "battle_boats/console_ui"
require "battle_boats/board"
require "battle_boats/fleet"
require "battle_boats/coordinate"

RSpec.describe BattleBoats::Engine do
  let(:console_ui) { instance_double(BattleBoats::ConsoleUI) }
  let(:ally_board) { instance_double(BattleBoats::Board) }
  let(:fleet) { instance_double(BattleBoats::Fleet) }
  let(:enemy_board) { instance_double(BattleBoats::Board) }
  subject(:engine) do
    described_class.new(interface: console_ui,
                        enemy_board: enemy_board,
                        ally_board: ally_board)
  end

  describe "#place_ships_manually" do
    it "walks the user through deploying their ships until all ships are deployed" do
      ship = BattleBoats::Ship.new(name: "foo", length: 1, symbol: "F")
      ships = [ship]
      coordinate = BattleBoats::Coordinate.new(row: 0, column: 0)
      orientation = :horizontal

      allow(ally_board).to receive(:fleet).and_return(fleet)
      allow(fleet).to receive(:ships).and_return(ships)
      allow(ally_board).to receive(:ship_deployed?).with(ship: ship).and_return(false, true)
      allow(console_ui).to receive(:display_ally_board).with(ally_board)
      allow(console_ui).to receive(:display_ship_data).with(ship: ship)
      allow(console_ui).to receive(:get_coordinate).and_return(coordinate)
      allow(console_ui).to receive(:get_orientation).and_return(orientation)

      expect(ally_board).to receive(:attempt_to_deploy_ship).with(ship: ship,
                                                                  coordinate: coordinate,
                                                                  orientation: orientation)
      engine.place_ships_manually
    end
  end

  describe "#start" do
    context "when the row and column input is valid" do
      it "plays the game until it is over" do
        row = "row"
        column = "column"
        coordinate = BattleBoats::Coordinate.new(row: row, column: column)
        status_report = "STATUS REPORT"
        ally_status_report = "ALLY STATUS REPORT"

        expect(console_ui).to receive(:greet).ordered

        expect(enemy_board).to receive(:game_over?).and_return(false)
        expect(ally_board).to receive(:game_over?).and_return(false)

        expect(ally_board).to receive(:status_report).and_return(ally_status_report).ordered
        expect(console_ui).to receive(:display_status_report).with(ally_status_report).ordered
        expect(console_ui).to receive(:display_ally_board).with(ally_board).ordered

        expect(enemy_board).to receive(:status_report).and_return(status_report).ordered
        expect(console_ui).to receive(:display_status_report).with(status_report).ordered
        expect(console_ui).to receive(:display_board).with(enemy_board).ordered

        expect(console_ui).to receive(:get_coordinate).and_return(coordinate).ordered
        expect(enemy_board).to receive(:strike_position).with(coordinate: coordinate).and_return(true).ordered

        expect(enemy_board).to receive(:get_random_coordinate).and_return(coordinate).ordered
        expect(ally_board).to receive(:strike_position).with(coordinate: coordinate).and_return(true).ordered

        expect(enemy_board).to receive(:game_over?).and_return(true)

        expect(console_ui).to receive(:display_ally_board).with(ally_board).ordered
        expect(console_ui).to receive(:display_board).with(enemy_board).ordered

        expect(console_ui).to receive(:win)

        engine.start
      end
    end

    context "when the row and column input is invalid" do
      it "prompts the user to re-enter a row and column" do
        row = "row"
        invalid_row = "invalid row"
        column = "column"
        coordinate = BattleBoats::Coordinate.new(row: row, column: column)
        invalid_coordinate = BattleBoats::Coordinate.new(row: invalid_row, column: column)
        error_message = "ERROR"
        status_report = "STATUS REPORT"
        ally_status_report = "ALLY STATUS REPORT"

        expect(console_ui).to receive(:greet).ordered

        expect(enemy_board).to receive(:game_over?).and_return(false)
        expect(ally_board).to receive(:game_over?).and_return(false)

        expect(ally_board).to receive(:status_report).and_return(ally_status_report).ordered
        expect(console_ui).to receive(:display_status_report).with(ally_status_report).ordered
        expect(console_ui).to receive(:display_ally_board).with(ally_board).ordered

        expect(enemy_board).to receive(:status_report).and_return(status_report).ordered
        expect(console_ui).to receive(:display_status_report).with(status_report).ordered
        expect(console_ui).to receive(:display_board).with(enemy_board).ordered

        expect(console_ui).to receive(:get_coordinate).and_return(invalid_coordinate).ordered
        expect(enemy_board).to receive(:strike_position).with(coordinate: invalid_coordinate).and_return(false).ordered
        expect(enemy_board).to receive(:status_report).and_return(error_message).ordered
        expect(console_ui).to receive(:display_status_report).with(error_message).ordered

        expect(console_ui).to receive(:get_coordinate).and_return(coordinate).ordered
        expect(enemy_board).to receive(:strike_position).with(coordinate: coordinate).and_return(true).ordered

        expect(enemy_board).to receive(:get_random_coordinate).and_return(invalid_coordinate).ordered
        expect(ally_board).to receive(:strike_position).with(coordinate: invalid_coordinate).and_return(false).ordered

        expect(enemy_board).to receive(:get_random_coordinate).and_return(coordinate).ordered
        expect(ally_board).to receive(:strike_position).with(coordinate: coordinate).and_return(true).ordered

        expect(enemy_board).to receive(:game_over?).and_return(true)

        expect(console_ui).to receive(:display_ally_board).with(ally_board).ordered
        expect(console_ui).to receive(:display_board).with(enemy_board).ordered

        expect(console_ui).to receive(:win)

        engine.start
      end
    end
  end
end

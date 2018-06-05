require "battle_boats/engine"
require "battle_boats/console_ui"
require "battle_boats/board"
require "battle_boats/coordinate"

RSpec.describe BattleBoats::Engine do
  let(:console_ui) { instance_double(BattleBoats::ConsoleUI) }
  let(:enemy_board) { instance_double(BattleBoats::Board) }
  subject(:engine) do
    described_class.new(interface: console_ui,
                        board: enemy_board)
  end

  describe "#start" do
    context "when the row and column input is valid" do
      it "plays the game until it is over" do
        row = "row"
        column = "column"
        coordinate = BattleBoats::Coordinate.new(row: row, column: column)
        status_report = "STATUS REPORT"

        expect(console_ui).to receive(:greet).ordered
        expect(enemy_board).to receive(:game_over?).and_return(false)
        expect(console_ui).to receive(:display_board).with(enemy_board).ordered
        expect(console_ui).to receive(:get_coordinate).and_return(coordinate).ordered
        expect(enemy_board).to receive(:strike_position).with(coordinate: coordinate).and_return(true).ordered
        expect(enemy_board).to receive(:status_report).and_return(status_report).ordered
        expect(console_ui).to receive(:display_status_report).with(status_report).ordered
        expect(enemy_board).to receive(:game_over?).and_return(true)
        expect(console_ui).to receive(:win)
        expect(console_ui).to receive(:display_board).with(enemy_board).ordered

        engine.start
      end
    end

    context "when the row and column input is invalid" do
      it "prompts the user to re-enter a row and column" do
        row = "row"
        column = "column"
        invalid_row = "invalid_row"
        coordinate = BattleBoats::Coordinate.new(row: row, column: column)
        invalid_coordinate = BattleBoats::Coordinate.new(row: invalid_row, column: column)
        error_message = "error"
        status_report = "STATUS REPORT"

        expect(console_ui).to receive(:greet).ordered
        expect(enemy_board).to receive(:game_over?).and_return(false)
        expect(console_ui).to receive(:display_board).with(enemy_board).ordered
        expect(console_ui).to receive(:get_coordinate).and_return(invalid_coordinate).ordered

        expect(enemy_board).to receive(:strike_position).with(coordinate: invalid_coordinate).and_return(false).ordered
        expect(enemy_board).to receive(:status_report).and_return(error_message).ordered
        expect(console_ui).to receive(:display_status_report).with(error_message).ordered

        expect(console_ui).to receive(:get_coordinate).and_return(coordinate).ordered

        expect(enemy_board).to receive(:strike_position).with(coordinate: coordinate).and_return(true).ordered
        expect(enemy_board).to receive(:status_report).and_return(status_report).ordered
        expect(console_ui).to receive(:display_status_report).with(status_report).ordered
        expect(enemy_board).to receive(:game_over?).and_return(true)
        expect(console_ui).to receive(:win)
        expect(console_ui).to receive(:display_board).with(enemy_board).ordered

        engine.start
      end
    end
  end
end

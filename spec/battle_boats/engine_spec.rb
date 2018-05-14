require 'battle_boats/engine'
require 'battle_boats/console_ui'
require 'battle_boats/board'

RSpec.describe BattleBoats::Engine do

  let(:console_ui) { instance_double(BattleBoats::ConsoleUI) }
  let(:board) { instance_double(BattleBoats::Board) }
  subject(:engine) { described_class.new(interface: console_ui,
                                         board: board) }

  describe '#start' do
    context 'when the row and column input is valid' do
      it 'starts the game' do
        row = "row"
        column = "column"
        status_report = "STATUS REPORT"

        expect(console_ui).to receive(:greet).ordered
        expect(console_ui).to receive(:display_board).with(board).ordered
        expect(console_ui).to receive(:get_row).and_return(row).ordered
        expect(console_ui).to receive(:get_column).and_return(column).ordered
        expect(board).to receive(:strike_position).with(row: row, column: column).and_return(true).ordered
        expect(board).to receive(:status_report).and_return(status_report).ordered
        expect(console_ui).to receive(:display_status_report).with(status_report).ordered
        expect(console_ui).to receive(:display_board).with(board).ordered

        engine.start
      end
    end
    context 'when the row and column input is invalid' do
      it 'prompts the user to re-enter a row and column' do
        row = "row"
        column = "column"
        invalid_row = "invalid_row"
        error_message = "error"
        status_report = "STATUS REPORT"

        expect(console_ui).to receive(:greet).ordered
        expect(console_ui).to receive(:display_board).with(board).ordered

        expect(console_ui).to receive(:get_row).and_return(invalid_row).ordered
        expect(console_ui).to receive(:get_column).and_return(column).ordered
        expect(board).to receive(:strike_position).with(row: invalid_row, column: column).and_return(false).ordered

        expect(console_ui).to receive(:get_row).and_return(row).ordered
        expect(console_ui).to receive(:get_column).and_return(column).ordered
        expect(board).to receive(:strike_position).with(row: row, column: column).and_return(true).ordered

        expect(board).to receive(:status_report).and_return(status_report).ordered
        expect(console_ui).to receive(:display_status_report).with(status_report).ordered
        expect(console_ui).to receive(:display_board).with(board).ordered

        engine.start
      end
    end
  end
end


require 'battle_boats/board'

RSpec.describe BattleBoats::Board do

  subject(:board) { described_class.new }

  describe '#play_area' do
    context 'when initialized' do
      it 'is a 10x10 Array of Arrays' do
        expect(board.play_area).to be_a Array
        expect(board.play_area.first).to be_a Array
        expect(board.play_area.first.length).to be 10
        expect(board.play_area.flatten.length).to be 100
      end
    end
  end

  describe '#strike_position' do
    context 'when the row and column are valid positions in the play area' do
      context 'when the cell at the given does not contain a ship' do
        it 'it strikes the cell and updates the status report' do
          row = 1
          column = 1
          result = board.strike_position(row: row, column: column)
          expect(result).to eq true
          expect(board.play_area[row][column]).to eq 'X'
          expect(board.status_report.downcase).to include 'miss'
        end
      end
    end
    context 'when the row is not a valid row in the play area' do
      it 'updates the error messages to include an "invalid row" statement' do
        row = 10
        column = 0
        result = board.strike_position(row: row, column: column)
        expect(result).to eq false
        expect(board.error_messages).to include('The selected row is invalid')
      end
    end
    context 'when the row is not a number between 0 and 9' do
      it 'updates the error messages to include an "invalid row" statement' do
        row = "hello"
        column = 0
        result = board.strike_position(row: row, column: column)
        expect(result).to eq false
        expect(board.error_messages).to include('The selected row is invalid')
      end
    end
    context 'when the column is not a valid row in the play area' do
      it 'updates the error messages to include an "invalid column" statement' do
        row = 0
        column = 10
        result = board.strike_position(row: row, column: column)
        expect(result).to eq false
        expect(board.error_messages).to include('The selected column is invalid')
      end
    end
    context 'when the column is not a number between 0 and 9' do
      it 'updates the error messages to include an "invalid column" statement' do
        row = 0
        column = "hello"
        result = board.strike_position(row: row, column: column)
        expect(result).to eq false
        expect(board.error_messages).to include('The selected column is invalid')
      end
    end
  end
end

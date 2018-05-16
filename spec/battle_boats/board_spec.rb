require 'battle_boats/board'
require 'battle_boats/cell'

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
      it 'is made up of unique Cell objects' do
        expect(board.play_area.flatten).to_not be_empty
        expect(board.play_area.flatten).to all be_instance_of BattleBoats::Cell
        expect(board.play_area.flatten.length).to eq(board.play_area.flatten.uniq.length)
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
          expect(board.cell_at(row: row, column: column)).to be_hit
          expect(board.status_report.downcase).to include('hit', 'nothing')
        end
      end

      context 'when the cell has already been hit' do
        it 'updates the error messages to include an "already hit" statement' do
          row = 1
          column = 1

          board.strike_position(row: row, column: column)
          result = board.strike_position(row: row, column: column)

          expect(result).to eq false
          expect(board.error_messages).to include('That position has already been hit')
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

    context 'when both the row and column are not valid' do
      it 'updates the error messages to include an "invalid row" and "invalid column" statement' do
        row = 420
        column = "hello"

        result = board.strike_position(row: row, column: column)

        expect(result).to eq false
        expect(board.error_messages).to include('The selected column is invalid')
        expect(board.error_messages).to include('The selected row is invalid')
      end
    end
  end

  describe '#game_over?' do
    it 'returns false' do
      expect(board.game_over?).to eq false
    end
  end

  describe '#cell_at' do
    context 'when the row and column are within the play_area' do
      it 'returns the cell located at that row and column' do
        row = 3
        column = 4

        expect(board.cell_at(row: row, column: column)).to be board.play_area[row][column]
      end
    end
    context 'when the row and column are not within the play_area' do
      it 'returns nil' do
        row = 8008
        column = 4

        expect(board.cell_at(row: row, column: column)).to eq nil
      end
    end
  end
end

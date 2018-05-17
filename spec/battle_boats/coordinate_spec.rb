require 'battle_boats/coordinate'

RSpec.describe BattleBoats::Coordinate do

  describe '#row' do
    it 'returns a row' do
      row = 5

      coordinate = BattleBoats::Coordinate.new(row: row)

      expect(coordinate.row).to eq row
    end
  end
  describe '#column' do
    it 'returns a column' do
      column = 5

      coordinate = BattleBoats::Coordinate.new(column: column)

      expect(coordinate.column).to eq column
    end
  end
end

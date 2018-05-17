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

  describe '#up' do
    it 'returns the coordinate above' do
      row = 9
      column = 1
      coordinate = BattleBoats::Coordinate.new(row: row, column: column)

      coordinate_above = coordinate.up

      expect(coordinate_above.row).to eq 8
    end
  end
  describe '#right' do
    it 'returns the coordinate too the right' do
      row = 1
      column = 1
      coordinate = BattleBoats::Coordinate.new(row: row, column: column)

      coordinate_to_the_right = coordinate.right

      expect(coordinate_to_the_right.column).to eq 2
    end
  end
end

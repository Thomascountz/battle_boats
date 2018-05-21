require "battle_boats/coordinate"

RSpec.describe BattleBoats::Coordinate do
  describe "#row" do
    it "returns a row" do
      row = 5

      coordinate = BattleBoats::Coordinate.new(row: row)

      expect(coordinate.row).to eq row
    end
  end
  describe "#column" do
    it "returns a column" do
      column = 5

      coordinate = BattleBoats::Coordinate.new(column: column)

      expect(coordinate.column).to eq column
    end
  end

  describe "#up" do
    it "returns the coordinate above" do
      row = 9
      column = 1
      offset = 2
      coordinate = BattleBoats::Coordinate.new(row: row, column: column)

      coordinate_above = coordinate.up(offset: offset)

      expect(coordinate_above.row).to eq 7
    end
  end
  describe "#right" do
    it "returns the coordinate to the right" do
      row = 1
      column = 1
      offset = 3
      coordinate = BattleBoats::Coordinate.new(row: row, column: column)

      coordinate_to_the_right = coordinate.right(offset: offset)

      expect(coordinate_to_the_right.column).to eq 4
    end
  end
end

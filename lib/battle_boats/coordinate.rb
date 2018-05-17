module BattleBoats
  class Coordinate
    attr_reader :row, :column

    def initialize(row: nil, column: column)
      @row = row
      @column = column
    end
  end
end

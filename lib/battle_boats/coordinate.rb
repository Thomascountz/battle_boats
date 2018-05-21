module BattleBoats
  class Coordinate
    attr_reader :row, :column

    def initialize(row: nil, column: nil)
      @row = row
      @column = column
    end

    def up(offset: 1)
      self.class.new(row: row - offset, column: column)
    end

    def right(offset: 1)
      self.class.new(row: row, column: column + offset)
    end
  end
end

module BattleBoats
  class Coordinate
    attr_reader :row, :column

    def initialize(row: nil, column: nil)
      @row = row
      @column = column
    end

    def up
      self.class.new(row: row - 1, column: column)
    end
  end
end

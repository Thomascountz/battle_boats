module BattleBoats
  class Coordinate
    class << self
      def random(row:, column:)
        row = rand(row)
        column = rand(column)
        new(row: row, column: column)
      end
    end

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

require "battle_boats/cell"

module BattleBoats
  class Board
    attr_reader :play_area, :status_report, :error_messages

    def initialize
      @status_report = ""
      @error_messages = []
      @play_area = []
      10.times do
        row = []
        10.times do
          row << BattleBoats::Cell.new
        end
        @play_area << row
      end
    end

    def strike_position(row:, column:)
      validate_position(row: row, column: column)
      if @error_messages.empty?
        cell = cell_at(row: row, column: column)
        cell.strike
        @status_report = cell.status_report
        true
      else
        false
      end
    end

    def game_over?
      false
    end

    def cell_at(row:, column:)
      if @play_area[row.to_i]
        @play_area[row.to_i][column.to_i]
      end
    end

    def place_ship_horizontally(row:, column:, ship:)
      cells_to_occupy = []
      ship.length.times do |i|
        cell = cell_at(row: row, column: column + i)
        if cell
          cells_to_occupy << cell
        end
      end
      cells_to_occupy.each do |cell|
        cell.occupant = ship
      end
    end

    def place_ship_vertically(row:, column:, ship:)
      cells_to_occupy = []
      ship.length.times do |i|
        cell = cell_at(row: row - i, column: column)
        if cell
          cells_to_occupy << cell
        end
      end
      cells_to_occupy.each do |cell|
        cell.occupant = ship
      end
    end

    private

    def validate_position(row:, column:)
      @error_messages.clear
      if !between_zero_and_nine?(row)
        @error_messages << "The selected row is invalid"
      end
      if !between_zero_and_nine?(column)
        @error_messages << "The selected column is invalid"
      end
      if @error_messages.empty?
        if !position_available?(row: row, column: column)
          @error_messages << "That position has already been hit"
        end
      end
    end

    def between_zero_and_nine?(input)
      if input.to_s =~ /^[0-9]$/
        true
      else
        false
      end
    end

    def position_available?(row:, column:)
      !cell_at(row: row, column: column).hit?
    end
  end
end

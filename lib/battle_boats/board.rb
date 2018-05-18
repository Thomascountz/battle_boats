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

    def strike_position(coordinate:)
      validate_position(coordinate: coordinate)
      if @error_messages.empty?
        cell = cell_at(coordinate: coordinate)
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

    def cell_at(coordinate:)
      row = coordinate.row
      column = coordinate.column
      if @play_area[row.to_i] && row.to_i >= 0 && column.to_i >= 0
        @play_area[row.to_i][column.to_i]
      end
    end

    def place_ship_horizontally(coordinate:, ship:)
      cells_to_occupy = Array.new(ship.length) do |offset|
        cell_at(coordinate: coordinate.right(offset: offset))
      end

      if cells_are_occupiable(cells_to_occupy)
        occupy_cells(cells: cells_to_occupy, ship: ship)
      else
        return false
      end
    end

    def place_ship_vertically(coordinate:, ship:)
      cells_to_occupy = Array.new(ship.length) do |offset|
        cell_at(coordinate: coordinate.up(offset: offset))
      end

      if cells_are_occupiable(cells_to_occupy)
        occupy_cells(cells: cells_to_occupy, ship: ship)
      else
        return false
      end
    end

    def cells_are_occupiable(cells)
      cells.none?(&:nil?) && cells.none?(&:occupied?)
    end

    def occupy_cells(cells:, ship:)
      cells.each do |cell|
        cell.occupant = ship
      end
    end

    private

    def validate_position(coordinate:)
      @error_messages.clear
      if !between_zero_and_nine?(coordinate.row)
        @error_messages << "The selected row is invalid"
      end
      if !between_zero_and_nine?(coordinate.column)
        @error_messages << "The selected column is invalid"
      end
      if @error_messages.empty?
        if !position_available?(coordinate: coordinate)
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

    def position_available?(coordinate:)
      !cell_at(coordinate: coordinate).hit?
    end
  end
end

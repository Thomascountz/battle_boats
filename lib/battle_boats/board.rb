require "battle_boats/cell"
require "battle_boats/fleet"

module BattleBoats
  class Board
    attr_reader :fleet, :play_area, :status_report

    def initialize(fleet: BattleBoats::Fleet.new)
      @fleet = fleet
      @status_report = ""
      @play_area = create_play_area
    end

    def place_ships_randomly
      @fleet.ships.each do |ship|
        until ship_deployed?(ship)
          coordinate = get_random_coordinate
          orientation = %i[horizontal vertical].sample
          if orientation == :horizontal
            place_ship_horizontally(coordinate: coordinate, ship: ship)
          elsif orientation == :vertical
            place_ship_vertically(coordinate: get_random_coordinate, ship: ship)
          end
        end
      end
    end

    def strike_position(coordinate:)
      cell = cell_at(coordinate: coordinate)
      if cell.hit?
        @status_report = "That position has already been hit"
        false
      else
        cell.strike
        @status_report = cell.status_report
        true
      end
    end

    def game_over?
      fleet.ships.all?(&:sunk?)
    end

    def cell_at(coordinate:)
      if within_range?(coordinate: coordinate)
        @play_area[coordinate.row.to_i][coordinate.column.to_i]
      end
    end

    def place_ship_horizontally(coordinate:, ship:)
      cells_to_occupy = Array.new(ship.length) do |offset|
        cell_at(coordinate: coordinate.right(offset: offset))
      end

      occupy_cells(cells: cells_to_occupy, ship: ship)
    end

    def place_ship_vertically(coordinate:, ship:)
      cells_to_occupy = Array.new(ship.length) do |offset|
        cell_at(coordinate: coordinate.up(offset: offset))
      end

      occupy_cells(cells: cells_to_occupy, ship: ship)
    end

    private

    def create_play_area
      Array.new(10) do
        row = []
        10.times do
          row << BattleBoats::Cell.new
        end
        row
      end
    end

    def within_range?(coordinate:)
      coordinate.row.between?(0, 9) && coordinate.column.between?(0, 9)
    end

    def ship_deployed?(ship)
      play_area.flatten.map(&:occupant).include?(ship)
    end

    def occupy_cells(cells:, ship:)
      if cells_are_occupiable(cells: cells)
        cells.each do |cell|
          cell.occupant = ship
        end
      else
        false
      end
    end

    def cells_are_occupiable(cells:)
      cells.none?(&:nil?) && cells.none?(&:occupied?)
    end

    def get_random_coordinate
      BattleBoats::Coordinate.random(row: 0..9, column: 0..9)
    end
  end
end

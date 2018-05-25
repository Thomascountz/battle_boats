module BattleBoats
  class ShipDeployer
    def initialize(board: BattleBoats::Board.new, interface: BattleBoats::DevConsoleUI.new)
      @board = board
      @ships = board.fleet.ships
      @interface = interface
    end

    def place_ships
      @ships.each do |ship|
        place_ship(ship)
      end
      @interface.display_board(@board)
      @board
    end

    def place_ship(ship)
      @interface.display_board(@board)
      puts "SHIP: #{ship.name}, LENGTH: #{ship.length}"
      coordinate = get_coordinate(ship)
      orientation = get_orientation(ship)
      if orientation == "h"
        if !@board.place_ship_horizontally(coordinate: coordinate, ship: ship)
          failure(ship)
        end
      elsif orientation == "v"
        if !@board.place_ship_vertically(coordinate: coordinate, ship: ship)
          failure(ship)
        end
      else
        failure(ship)
      end
    end

    def get_coordinate(ship)
      puts "Where whould you like to place your #{ship.name}?"
      coordinate = @interface.get_coordinate
    end

    def get_orientation(ship)
      puts "Would you like to place your #{ship.name} horizontally or vertically? [h,v]"
      orientation = gets.chomp.downcase
    end

    def failure(ship)
      puts "FAIL"
      place_ship(ship)
    end
  end
end

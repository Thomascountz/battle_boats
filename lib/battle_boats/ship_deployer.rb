module BattleBoats
  class ShipDeployer
    def initialize(board: BattleBoats::Board.new,
                   interface: BattleBoats::DevConsoleUI.new,
                   fleet: BattleBoats::Fleet.new)
      @board = board
      @ships = fleet.ships
      @interface = interface
    end

    def place_ships_randomly
      @ships.each do |ship|
        coin_flip = ["heads", "tails"].sample
        if coin_flip == "heads"
          until @board.place_ship_horizontally(coordinate: get_random_coordinate, ship: ship)
          end
        else
          until @board.place_ship_vertically(coordinate: get_random_coordinate, ship: ship)
          end
        end
      end
      @board
    end

    def place_ships_manually
      @ships.each do |ship|
        place_ship(ship)
      end
      @interface.display_board(@board)
      @board
    end

    private

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

    def get_random_coordinate
      BattleBoats::Coordinate.random(row: 0..9, column: 0..9)
    end
  end
end

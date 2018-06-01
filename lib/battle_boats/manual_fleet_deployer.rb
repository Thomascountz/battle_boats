require_relative "console_ui"
require_relative "board"

module BattleBoats
  class ManualFleetDeployer
    def initialize(interface: BattleBoats::ConsoleUI.new)
      @interface = interface
      @board = nil
    end

    def deploy(fleet)
      @board = BattleBoats::Board.new(fleet: fleet, state: :ally)
      fleet.ships.each do |ship|
        place_ship(ship)
      end
      @interface.display_board(@board)
      @board
    end

    private

    def place_ship(ship)
      @interface.display_board(@board)
      @interface.display_ship_data(ship)
      @interface.prompt_ship_placement_coordinate(ship)
      coordinate = @interface.get_coordinate
      @interface.prompt_ship_placement_orientation(ship)
      orientation = @interface.get_orientation
      if orientation == :horizontal
        if !@board.place_ship_horizontally(coordinate: coordinate, ship: ship)
          place_ship(ship)
        end
      elsif orientation == :vertical
        if !@board.place_ship_vertically(coordinate: coordinate, ship: ship)
          place_ship(ship)
        end
      end
    end
  end
end

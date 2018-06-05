require_relative "board"
require_relative "console_ui"

module BattleBoats
  class Engine
    def initialize(interface: BattleBoats::ConsoleUI.new,
                   enemy_board: BattleBoats::Board.new,
                   ally_board: BattleBoats::Board.new)
      @interface = interface
      @enemy_board = enemy_board
      @ally_board = ally_board
    end

    def deploy_ally_ships
      ally_board.fleet.ships.each do |ship|
        until ally_board.ship_deployed?(ship: ship)
          interface.display_board(ally_board)
          coordinate = interface.get_coordinate
          orientation = interface.get_orientation
          ally_board.attempt_to_deploy_ship(ship: ship,
                                            coordinate: coordinate,
                                            orientation: orientation)
        end
      end
    end

    def start
      interface.greet
      until enemy_board.game_over?
        interface.display_board(enemy_board)
        coordinate = interface.get_coordinate
        until enemy_board.strike_position(coordinate: coordinate)
          interface.display_status_report(enemy_board.status_report)
          coordinate = interface.get_coordinate
        end
        interface.display_status_report(enemy_board.status_report)
      end
      interface.win
      interface.display_board(enemy_board)
    end

    private

    attr_reader :interface, :enemy_board, :ally_board
  end
end

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

    def place_ships_manually
      ally_board.fleet.ships.each do |ship|
        until ally_board.ship_deployed?(ship: ship)
          interface.display_ally_board(ally_board)
          interface.display_ship_data(ship: ship)

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
      until game_over?

        interface.display_status_report(ally_board.status_report)
        interface.display_ally_board(ally_board)

        interface.display_status_report(enemy_board.status_report)
        interface.display_board(enemy_board)

        coordinate = interface.get_coordinate
        until enemy_board.strike_position(coordinate: coordinate)
          interface.display_status_report(enemy_board.status_report)
          coordinate = interface.get_coordinate
        end

        enemy_coordinate = enemy_board.get_random_coordinate
        until ally_board.strike_position(coordinate: enemy_coordinate)
          enemy_coordinate = enemy_board.get_random_coordinate
        end

      end
      end_game
    end

    private

    def game_over?
      enemy_board.game_over? || ally_board.game_over?
    end

    def end_game
      interface.display_ally_board(ally_board)
      interface.display_board(enemy_board)
      if enemy_board.game_over?
        interface.win
      else
        interface.lose
      end
    end

    attr_reader :interface, :enemy_board, :ally_board
  end
end

require_relative "board"
require_relative "console_ui"

module BattleBoats
  class Engine
    def initialize(interface: BattleBoats::ConsoleUI.new,
                   board: BattleBoats::Board.new)
      @interface = interface
      @board = board
    end

    def start
      interface.greet
      until board.game_over?
        interface.display_board(board)
        coordinate = interface.get_coordinate
        until board.strike_position(coordinate: coordinate)
          interface.display_errors(board.error_messages)
          coordinate = interface.get_coordinate
        end
        interface.display_status_report(board.status_report)
      end
      interface.win
      interface.display_board(board)
    end

    private

    attr_reader :interface, :board
  end
end

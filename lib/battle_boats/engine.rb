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
        row = interface.get_row
        column = interface.get_column
        until board.strike_position(row: row, column: column)
          interface.display_errors(board.error_messages)
          row = interface.get_row
          column = interface.get_column
        end
        status_report = board.status_report
        interface.display_status_report(status_report)
      end
    end

    private

    attr_reader :interface, :board
  end
end

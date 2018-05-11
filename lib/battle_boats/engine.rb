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
      interface.display_board(board)
      row = interface.get_row
      column = interface.get_column
      board.strike_position(row: row, column: column)
      status_report = board.status_report
      interface.display_status_report(status_report)
      interface.display_board(board)
    end

    private

    attr_reader :interface, :board
  end
end

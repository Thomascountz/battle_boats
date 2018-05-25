require_relative "console_ui"
require_relative "coordinate"
require_relative "colorize"

module BattleBoats
  class DevConsoleUI < ConsoleUI
    using Colorize
    def format_board(board)
      board_string = horizontal_line
      board_string << newline
      board_string << column_label
      board_string << horizontal_line
      board_string << newline
      board.play_area.each_with_index do |row, row_number|
        board_string << pipe
        board_string << "  #{row_labels[row_number]}  "
        board_string << pipe
        row.each do |cell|
          board_string << if cell.hit?
                            "  #{cell.occupant.symbol.red}  "
                          elsif cell.occupied?
                            "  #{cell.occupant.symbol.yellow}  "
                          else
                            "  #{cell.occupant.symbol.blue}  "
                          end
          board_string << pipe
        end
        board_string << newline
        board_string << horizontal_line
        board_string << newline
      end
      board_string
    end
  end
end

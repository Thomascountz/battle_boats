module BattleBoats
  class BoardFormatter
    using Colorize
    def format_board(board, enemy: true)
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
          board_string << if cell.occupied? && cell.hit?
                            "  #{cell.occupant.symbol.red}  "
                          elsif cell.occupied? && enemy
                            "  #{'~'.blue}  "
                          elsif cell.occupied? && !enemy
                            "  #{cell.occupant.symbol.yellow}  "
                          elsif cell.hit?
                            "  #{cell.occupant.symbol.yellow}  "
                          else
                            "  #{'~'.blue}  "
                          end
          board_string << pipe
        end
        board_string << newline
        board_string << horizontal_line
        board_string << newline
      end
      board_string
    end

    def column_label
      "|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n"
    end

    def row_labels
      ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    end

    def newline
      "\n"
    end

    def horizontal_line
      "-" * 67
    end

    def pipe
      "|"
    end
  end
end

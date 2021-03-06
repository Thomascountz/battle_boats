require_relative "colorize"

module BattleBoats
  class BoardFormatter
    using Colorize
    def format_board(board, hide_ships: true)
      board_string = horizontal_line
      board_string << newline
      board_string << column_header
      board_string << horizontal_line
      board_string << newline
      board.play_area.each_with_index do |row, row_number|
        board_string << pipe
        board_string << "  #{row_labels[row_number]}  "
        board_string << pipe
        row.each do |cell|
          board_string << if cell.occupied? && cell.hit?
                            "  #{cell.occupant.symbol.red}  "
                          elsif cell.occupied? && !hide_ships
                            "  #{cell.occupant.symbol.green}  "
                          elsif cell.hit?
                            "  #{'X'.yellow}  "
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

    def valid_coordinate_input?(input)
      input =~ /^[A-J][0-9]$/i
    end

    def input_to_coordinate(input)
      input_row = input[0]
      input_column = input[1]
      row = row_label_to_row_number(input_row)
      column = column_label_to_column_number(input_column)
      BattleBoats::Coordinate.new(row: row, column: column)
    end

    def row_label_to_row_number(row_label)
      row_labels.index(row_label.upcase)
    end

    def column_label_to_column_number(column_label)
      column_label.to_i
    end

    private

    def column_header
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

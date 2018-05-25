require_relative "coordinate"

module BattleBoats
  class ConsoleUI
    def initialize(output: $stdout, input: $stdin)
      @output = output
      @input = input
    end

    def greet
      output.puts "Welcome to Battle Boats!"
    end

    def display_board(board)
      output.puts format_board(board)
    end

    def get_coordinate
      output.puts "Target coordinate: "
      user_input = input.gets.chomp
      until valid_input?(user_input)
        output.puts "Coordinate invalid."
        user_input = input.gets.chomp
      end
      input_to_coordinate(user_input)
    end

    def display_status_report(status_report)
      output.puts status_report
    end

    def win
      output.puts "You've won the game!"
    end

    private

    attr_reader :output, :input

    def valid_input?(coordinate)
      coordinate =~ /^[A-J][0-9]$/i
    end

    def input_to_coordinate(input)
      input_row = input[0]
      input_column = input[1]
      row = row_labels.index(input_row.upcase)
      column = input_column.to_i
      BattleBoats::Coordinate.new(row: row, column: column)
    end

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
          board_string << "  #{cell}  "
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

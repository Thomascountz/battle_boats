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
      row = get_row
      column = get_column
      BattleBoats::Coordinate.new(row: row, column: column)
    end

    def display_status_report(status_report)
      output.puts status_report
    end

    def display_errors(errors)
      output.puts errors
    end

    private

    attr_reader :output, :input

    def format_board(board)
      board_string = horizontal_line
      board_string << newline
      board_string << top_row
      board_string << horizontal_line
      board_string << newline
      board.play_area.each_with_index do |row, row_number|
        board_string << pipe
        board_string << "  #{row_number}  "
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

    def top_row
      "|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n"
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

    def get_row
      output.puts "Target row:"
      input.gets.chomp
    end

    def get_column
      output.puts "Target column:"
      input.gets.chomp
    end
  end
end

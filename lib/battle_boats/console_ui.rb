require_relative "coordinate"
require_relative "board_formatter"

module BattleBoats
  class ConsoleUI
    def initialize(output: $stdout,
                   input: $stdin,
                   board_formatter: BattleBoats::BoardFormatter.new)
      @output = output
      @input = input
      @board_formatter = board_formatter
    end

    def greet
      output.puts "Welcome to Battle Boats!"
    end

    def display_board(board)
      output.puts board_formatter.format_board(board, hide_ships: true)
    end

    def display_ally_board(board)
      output.puts board_formatter.format_board(board, hide_ships: false)
    end

    def display_ship_data(ship:)
      output.puts "SHIP: #{ship.name} ALIAS: #{ship.symbol}"
      output.puts "LENGTH: #{ship.length}"
    end

    def get_coordinate
      output.puts "Target coordinate: "
      user_input = input.gets.chomp
      until board_formatter.valid_coordinate_input?(user_input)
        output.puts "Coordinate invalid."
        user_input = input.gets.chomp
      end
      input_to_coordinate(user_input)
    end

    def get_orientation
      output.puts "Orientation [hV]:"
      user_input = input.gets.chomp
      until valid_orientation_input?(user_input)
        output.puts "Orientation invalid."
        user_input = input.gets.chomp
      end
      input_to_orientation(user_input)
    end

    def display_status_report(status_report)
      output.puts status_report
    end

    def win
      output.puts "You've won the game!"
    end

    private

    attr_reader :output, :input, :board_formatter

    def valid_orientation_input?(orientation)
      orientation =~ /^[h{1}|v{1}]$/i
    end

    def input_to_coordinate(input)
      input_row = input[0]
      input_column = input[1]
      row = board_formatter.row_label_to_row_number(input_row)
      column = board_formatter.column_label_to_column_number(input_column)
      BattleBoats::Coordinate.new(row: row, column: column)
    end

    def input_to_orientation(input)
      if input =~ /^[h{1}]$/i
        :horizontal
      elsif input =~ /^[v{1}]$/i
        :vertical
      end
    end
  end
end

module BattleBoats
  class ConsoleUI
    def initialize(output: $stdout)
      @output = output
    end

    def greet
      output.puts "Welcome to Battle Boats!"
    end

    def display_board(board)
      raise NotImplementedError
    end

    def get_row
      raise NotImplementedError
    end

    def get_column
      raise NotImplementedError
    end

    def display_status_report(status_report)
      raise NotImplementedError
    end

    private

    attr_reader :output
  end
end

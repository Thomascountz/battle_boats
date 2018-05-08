module BattleBoats
  class ConsoleUI
    def initialize(output: $stdout)
      @output = output
    end

    def greet
      output.puts "Welcome to Battle Boats!"
    end

    private

    attr_reader :output
  end
end

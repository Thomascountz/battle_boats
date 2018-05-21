require_relative "null_ship"
require_relative "colorize"

module BattleBoats
  using Colorize
  class Cell
    attr_accessor :occupant

    def initialize
      @hit = false
      @occupant = BattleBoats::NullShip.new
    end

    def hit?
      @hit
    end

    def strike
      if !hit?
        @hit = true
      end
    end

    def to_s
      if hit?
        occupant.symbol
      else
        ".".blue
      end
    end

    def status_report
      if hit?
        "You hit my #{occupant.name}!"
      else
        "All Clear!"
      end
    end

    def occupied?
      !occupant.empty?
    end
  end
end

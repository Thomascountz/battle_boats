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
        occupant.hit
        @hit = true
      end
    end

    def to_s
      if hit?
        occupant.to_ansi
      else
        to_ansi
      end
    end

    def status_report
      occupant_name = occupant.name
      if occupant.sunk?
        "You sunk my #{occupant_name}!"
      elsif hit?
        "You hit my #{occupant_name}!"
      end
    end

    def occupied?
      !occupant.empty?
    end

    private

    def to_ansi
      "~".blue
    end
  end
end

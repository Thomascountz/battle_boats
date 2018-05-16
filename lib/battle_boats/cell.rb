require_relative "null_ship"

module BattleBoats
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
        "X"
      else
        "."
      end
    end

    def status_report
      if hit?
        "You hit my #{occupant.name}!"
      else
        "All Clear!"
      end
    end
  end
end

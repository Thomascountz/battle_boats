module BattleBoats
  class Cell
    attr_reader :occupant

    def initialize
      @hit = false
      @occupant = nil
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
  end
end

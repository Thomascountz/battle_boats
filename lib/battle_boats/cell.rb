module BattleBoats
  class Cell
    def initialize
      @hit = false
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

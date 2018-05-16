module BattleBoats
  class Cell
    attr_accessor :occupant

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

    def status_report
      if hit?
        if occupant
          "You hit my #{occupant.name}!"
        else
          "You hit nothing"
        end
      else
        "All Clear!"
      end
    end
  end
end

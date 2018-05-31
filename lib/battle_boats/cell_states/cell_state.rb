require_relative "../colorize"
module BattleBoats
  class CellState
    def initialize(cell)
      @cell = cell
    end

    def strike; end

    def hit?; end

    def to_s; end

    def status_report; end

    def occupied?
      !@cell.occupant.empty?
    end
  end

  class HiddenState < CellState
    using Colorize
    def strike
      new_state = BattleBoats::HitState.new(@cell)
      @cell.change_state(new_state)
      @cell.occupant.hit
    end

    def hit?
      false
    end

    def to_s
      "~".blue
    end
  end

  class RevealedState < CellState
    def strike
      new_state = BattleBoats::HitState.new(@cell)
      @cell.change_state(new_state)
      @cell.occupant.hit
    end

    def hit?
      false
    end

    def to_s
      @cell.occupant.to_ansi
    end
  end

  class EmptyState < CellState
    using Colorize
    def strike
      new_state = BattleBoats::MissedState.new(@cell)
      @cell.change_state(new_state)
    end

    def hit?
      false
    end

    def to_s
      "~".blue
    end
  end

  class HitState < CellState
    def hit?
      true
    end

    def to_s
      @cell.occupant.to_ansi
    end

    def status_report
      occupant_name = @cell.occupant.name
      if @cell.occupant.sunk?
        "You sunk my #{occupant_name}!"
      elsif hit?
        "You hit my #{occupant_name}!"
      end
    end
  end

  class MissedState < CellState
    using Colorize
    def hit?
      true
    end

    def to_s
      "X".yellow
    end

    def status_report
      "You hit my nothing"
    end
  end
end

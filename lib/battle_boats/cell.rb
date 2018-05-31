require_relative "null_ship"
require_relative "colorize"
require_relative "cell_states/cell_state"

module BattleBoats
  class Cell
    attr_reader :occupant

    def initialize
      @state = BattleBoats::EmptyState.new(self)
      @occupant = BattleBoats::NullShip.new
    end

    def change_state(state)
      @state = state
    end

    def hit?
      @state.hit?
    end

    def strike
      @state.strike
    end

    def to_s
      @state.to_s
    end

    def status_report
      @state.status_report
    end

    def occupied?
      @state.occupied?
    end

    def occupant=(ship)
      @occupant = ship
      if ship.class == BattleBoats::Ship
        new_state = BattleBoats::HiddenState.new(self)
        change_state(new_state)
      else
        new_state = BattleBoats::EmptyState.new(self)
        change_state(new_state)
      end
    end
  end
end

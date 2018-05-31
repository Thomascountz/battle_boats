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
      @state = BattleBoats::HiddenState.new(self)
    end
  end
end

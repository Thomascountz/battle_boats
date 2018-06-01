require_relative "colorize"
require_relative "cell_states/cell_state"

module BattleBoats
  class Cell
    class << self
      def for(state:)
        cell = Cell.new
        case state
        when :enemy
          enemy_state = BattleBoats::EnemyState.new(cell)
          cell.change_state(enemy_state)
        when :ally
          ally_state = BattleBoats::AllyState.new(cell)
          cell.change_state(ally_state)
        end
        cell
      end
    end

    attr_reader :occupant

    def initialize
      @state = BattleBoats::EmptyState.new(self)
      @occupant = nil
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
      new_state = BattleBoats::HiddenState.new(self)
      change_state(new_state)
    end
  end
end

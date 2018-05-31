require_relative "colorize"

module BattleBoats
  using Colorize
  class NullShip
    attr_reader :length, :symbol

    def initialize
      @length = 1
      @symbol = "X"
    end

    def hit; end

    def sunk?; end
  end
end

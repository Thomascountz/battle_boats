require_relative "colorize"

module BattleBoats
  using Colorize
  class NullShip
    attr_reader :name, :length, :symbol

    def initialize
      @name = "nothing"
      @length = 1
      @symbol = "X"
    end

    def empty?
      true
    end

    def to_ansi
      @symbol.yellow
    end

    def hit; end

    def sunk?; end
  end
end

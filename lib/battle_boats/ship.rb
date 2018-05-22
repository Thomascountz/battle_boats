require_relative "colorize"

module BattleBoats
  using Colorize
  class Ship
    attr_reader :name, :length, :symbol

    def initialize(name:, length:, symbol: "O")
      @name = name
      @length = length
      @symbol = symbol.red
      @hits = 0
    end

    def empty?
      false
    end

    def hit_count
      @hits
    end

    def hit
      @hits += 1
    end

    def sunk?
      hit_count == length
    end
  end
end

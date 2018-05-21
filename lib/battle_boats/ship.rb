require_relative "colorize"

module BattleBoats
  using Colorize
  class Ship
    attr_reader :name, :length, :symbol

    def initialize(name:, length:, symbol: "O")
      @name = name
      @length = length
      @symbol = symbol.red
    end

    def empty?
      false
    end
  end
end

module BattleBoats
  class Ship
    attr_reader :name, :length, :symbol

    def initialize(name:, length:, symbol: "O")
      @name = name
      @length = length
      @symbol = symbol
      @hits = 0
    end

    def empty?
      false
    end

    def hit
      @hits += 1
    end

    def sunk?
      @hits == length
    end
  end
end

module BattleBoats
  class Ship
    attr_reader :name, :length, :symbol

    def initialize(name:, length:, symbol: "O")
      @name = name
      @length = length
      @symbol = symbol
    end
  end
end

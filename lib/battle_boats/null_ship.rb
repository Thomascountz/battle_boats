module BattleBoats
  class NullShip
    attr_reader :name, :length, :symbol

    def initialize(name: nil, length: nil, symbol: nil)
      @name = "nothing"
      @length = 1
      @symbol = 'X'
    end
  end
end

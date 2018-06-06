module BattleBoats
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

    def hit; end

    def sunk?; end
  end
end

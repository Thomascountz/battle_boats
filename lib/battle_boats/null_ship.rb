module BattleBoats
  class NullShip
    attr_reader :name, :length

    def initialize(name: nil, length: nil)
      @name = "nothing"
      @length = 1
    end
  end
end

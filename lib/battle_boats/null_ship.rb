require_relative "colorize"

module BattleBoats
  using Colorize
  class NullShip
    attr_reader :name, :length, :symbol

    def initialize
      @name = "nothing"
      @length = 1
      @symbol = "X".yellow
    end

    def empty?
      true
    end
  end
end

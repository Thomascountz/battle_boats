require_relative "ship"

module BattleBoats
  class Fleet
    attr_reader :ships

    def initialize
      @ships = [
        BattleBoats::Ship.new(name: "Carrier", length: 5, symbol: "C"),
        BattleBoats::Ship.new(name: "Battleship", length: 4, symbol: "B"),
        BattleBoats::Ship.new(name: "Cruiser",    length: 3, symbol: "R"),
        BattleBoats::Ship.new(name: "Submarine",  length: 3, symbol: "S"),
        BattleBoats::Ship.new(name: "Destroyer",  length: 2, symbol: "D"),
      ]
    end
  end
end

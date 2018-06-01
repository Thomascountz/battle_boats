require_relative "board"
require_relative "coordinate"

module BattleBoats
  class RandomFleetDeployer
    def initialize(board: BattleBoats::Board.new(state: :enemy))
      @board = board
    end

    def deploy(fleet)
      fleet.ships.each do |ship|
        coin_flip = ["heads", "tails"].sample
        if coin_flip == "heads"
          until @board.place_ship_horizontally(coordinate: get_random_coordinate, ship: ship)
          end
        else
          until @board.place_ship_vertically(coordinate: get_random_coordinate, ship: ship)
          end
        end
      end
      @board
    end

    private

    def get_random_coordinate
      BattleBoats::Coordinate.random(row: 0..9, column: 0..9)
    end
  end
end

module BattleBoats
  class Board

    attr_reader :play_area

    def initialize
      @play_area = []
      10.times do
        row = []
        10.times do
          row << nil
        end
        @play_area << row
      end
    end

  end
end

module BattleBoats
  class Board
    attr_reader :play_area, :status_report, :error_messages

    def initialize
      @status_report = ""
      @error_messages = []
      @play_area = []
      10.times do
        row = []
        10.times do
          row << nil
        end
        @play_area << row
      end
    end

    def strike_position(row:, column:)
      if validate_position(row: row)
        @play_area[row.to_i][column.to_i] = "X"
        @status_report = "Miss!"
      end
    end

    private

    def validate_position(row:)
      @error_messages.clear
      if @play_area[row.to_i]
        return true
      else
        @error_messages << "The selected row is invalid"
        return false
      end
    end
  end
end

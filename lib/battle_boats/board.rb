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
      validate_position(row: row)
      if @error_messages.empty?
        @play_area[row.to_i][column.to_i] = "X"
        @status_report = "Miss!"
        true
      else
        false
      end
    end

    private

    def validate_position(row:)
      @error_messages.clear
      if !between_zero_and_nine?(row)
        @error_messages << "The selected row is invalid"
      end
    end

    def between_zero_and_nine?(input)
      if input.to_s =~ /^[0-9]$/
        true
      else
        false
      end
    end
  end
end

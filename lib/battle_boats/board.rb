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
      validate_position(row: row, column: column)
      if @error_messages.empty?
        @play_area[row.to_i][column.to_i] = "X"
        @status_report = "Miss!"
        true
      else
        false
      end
    end

    def game_over?
      false
    end

    private

    def validate_position(row:, column:)
      @error_messages.clear
      if !between_zero_and_nine?(row)
        @error_messages << "The selected row is invalid"
      end
      if !between_zero_and_nine?(column)
        @error_messages << "The selected column is invalid"
      end
      if @error_messages.empty?
        if !position_available?(row: row, column: column)
         @error_messages << "That position has already been hit"
        end
      end
    end

    def between_zero_and_nine?(input)
      if input.to_s =~ /^[0-9]$/
        true
      else
        false
      end
    end

    def position_available?(row:, column:)
      @play_area[row.to_i][column.to_i] != 'X'
    end
  end
end

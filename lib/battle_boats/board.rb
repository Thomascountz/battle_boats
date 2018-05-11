module BattleBoats
	class Board
		attr_reader :play_area, :status_report

		def initialize
			@status_report = ""
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
			@play_area[row.to_i][column.to_i] = "X"
			@status_report = "Miss!"
		end

	end
end

require "battle_boats/board_formatter"

RSpec.describe BattleBoats::BoardFormatter do
  let(:board_formatter) { described_class.new }

  describe "#format_board" do
    context "when the board is empty" do
      context "when there are no misses" do
        it "prints an empty board to output" do
          board = BattleBoats::Board.new
          result = board_formatter.format_board(board)

          expected = "-------------------------------------------------------------------\n|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n-------------------------------------------------------------------\n|  A  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |\n-------------------------------------------------------------------\n"

          expect(result).to include expected
        end
      end
      context "when there has been a miss" do
        it "shows the cell as having been hit" do
          board = BattleBoats::Board.new
          coordinate = BattleBoats::Coordinate.new(row: 0, column: 0)
          cell = board.cell_at(coordinate: coordinate)
          cell.strike

          result = board_formatter.format_board(board)

          expected = "-------------------------------------------------------------------\n|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n-------------------------------------------------------------------\n|  A  |  \e[33mX\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |\n-------------------------------------------------------------------\n"

          expect(result).to include expected
        end
      end
    end

    context "when an enemy ship is on the board" do
      context "when the ship is not hit" do
        it "prints an empty-looking board to output" do
          board = BattleBoats::Board.new
          ship = BattleBoats::Ship.new(name: "foo", length: 1, symbol: "F")
          coordinate = BattleBoats::Coordinate.new(row: 0, column: 0)
          board.cell_at(coordinate: coordinate).occupant = ship

          result = board_formatter.format_board(board)

          expected = "-------------------------------------------------------------------\n|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n-------------------------------------------------------------------\n|  A  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |\n-------------------------------------------------------------------\n"

          expect(result).to include expected
        end
      end
    end
    context "when the ship is hit" do
      it "shows the ship as having been hit" do
        board = BattleBoats::Board.new
        ship = BattleBoats::Ship.new(name: "foo", length: 1, symbol: "F")
        coordinate = BattleBoats::Coordinate.new(row: 0, column: 0)
        cell = board.cell_at(coordinate: coordinate)
        cell.occupant = ship
        cell.strike

        result = board_formatter.format_board(board)

        expected = "-------------------------------------------------------------------\n|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n-------------------------------------------------------------------\n|  A  |  \e[31mF\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |\n-------------------------------------------------------------------\n"

        expect(result).to include expected
      end
    end

    context "when an ally ship is on the board" do
      context "when the ship is not hit" do
        it "shows the ship on the board" do
          board = BattleBoats::Board.new
          ship = BattleBoats::Ship.new(name: "foo", length: 1, symbol: "F")
          coordinate = BattleBoats::Coordinate.new(row: 0, column: 0)
          board.cell_at(coordinate: coordinate).occupant = ship

          result = board_formatter.format_board(board, enemy: false)

          expected = "-------------------------------------------------------------------\n|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n-------------------------------------------------------------------\n|  A  |  \e[33mF\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |\n-------------------------------------------------------------------\n"

          expect(result).to include expected
        end
      end
    end
    context "when the ship is hit" do
      it "shows the ship as having been hit" do
        board = BattleBoats::Board.new
        ship = BattleBoats::Ship.new(name: "foo", length: 1, symbol: "F")
        coordinate = BattleBoats::Coordinate.new(row: 0, column: 0)
        cell = board.cell_at(coordinate: coordinate)
        cell.occupant = ship
        cell.strike

        result = board_formatter.format_board(board)

        expected = "-------------------------------------------------------------------\n|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n-------------------------------------------------------------------\n|  A  |  \e[31mF\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |\n-------------------------------------------------------------------\n"

        expect(result).to include expected
      end
    end
  end

  describe "#valid_coordinate_input?" do
    context "when the coordinate is valid" do
      it "returns truthy" do
        valid_input = "A1"
        result = board_formatter.valid_coordinate_input?(valid_input)
        
        expect(result).to be_truthy
      end
    end
    context "when the coordinate is invalid" do
      it "returns falsey" do
        valid_input = "A11"
        result = board_formatter.valid_coordinate_input?(valid_input)
        
        expect(result).to be_falsey
      end
    end
  end

  describe "#row_label_to_row_number" do
    it "returns a row number based on row labels" do
      row_label = "A"
      result = board_formatter.row_label_to_row_number(row_label)

      expect(result).to be 0
    end
  end

  describe "#column_label_to_column_number" do
    it "returns a row number based on row labels" do
      column_number = 0 
      result = board_formatter.column_label_to_column_number(column_number)

      expect(result).to be 0
    end
  end
end

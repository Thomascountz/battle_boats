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
end

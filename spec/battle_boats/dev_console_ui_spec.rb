require "battle_boats/dev_console_ui"
require "battle_boats/board"
require "battle_boats/coordinate"

RSpec.describe BattleBoats::DevConsoleUI do
  let(:output) { StringIO.new }
  subject(:dev_console_ui) { described_class.new(output: output) }

  describe "#display_board" do
    context "when no cells are hit" do
      context "when the cells are empty" do
        it "prints the board to output" do
          board = BattleBoats::Board.new

          dev_console_ui.display_board(board)

          expected = "-------------------------------------------------------------------\n|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n-------------------------------------------------------------------\n|  A  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |\n-------------------------------------------------------------------\n"

          expect(output.string).to include expected
        end
      end
      context "when the cell is occupied" do
        it "shows the occupant in the cell" do
          board = BattleBoats::Board.new
          coordinate = BattleBoats::Coordinate.new(row: 0, column: 0)
          ship = BattleBoats::Ship.new(name: "Foo", length: 1)
          cell = board.cell_at(coordinate: coordinate)
          cell.occupant = ship

          dev_console_ui.display_board(board)

          expected = "-------------------------------------------------------------------\n|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n-------------------------------------------------------------------\n|  A  |  \e[33mO\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |\n-------------------------------------------------------------------\n"

          expect(output.string).to include expected
        end
      end
    end
    context "when a cell is hit" do
      context "when the cell is empty" do
        it "shows the cell is hit" do
          board = BattleBoats::Board.new
          coordinate = BattleBoats::Coordinate.new(row: 0, column: 0)
          cell = board.cell_at(coordinate: coordinate)
          cell.strike

          dev_console_ui.display_board(board)

          expected = "-------------------------------------------------------------------\n|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n-------------------------------------------------------------------\n|  A  |  \e[31mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |\n-------------------------------------------------------------------\n"

          expect(output.string).to include expected
        end
      end
      context "when the cell is occupied" do
        it "shows the occupant has been hit" do
          board = BattleBoats::Board.new
          coordinate = BattleBoats::Coordinate.new(row: 0, column: 0)
          ship = BattleBoats::Ship.new(name: "Foo", length: 1)
          cell = board.cell_at(coordinate: coordinate)
          cell.occupant = ship
          cell.strike

          dev_console_ui.display_board(board)

          expected = "-------------------------------------------------------------------\n|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n-------------------------------------------------------------------\n|  A  |  \e[31mO\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |  \e[34mX\e[0m  |\n-------------------------------------------------------------------\n"

          expect(output.string).to include expected
        end
      end
    end
  end
end

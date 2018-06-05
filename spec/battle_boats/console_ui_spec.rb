require "battle_boats/console_ui"
require "battle_boats/board"
require "battle_boats/ship"
require "battle_boats/coordinate"

RSpec.describe BattleBoats::ConsoleUI do
  let(:output) { StringIO.new }
  subject(:console_ui) { described_class.new(output: output) }

  describe "#greet" do
    it "prints a greeting to output" do
      console_ui.greet

      expect(output.string.downcase).to include("welcome", "battle boats")
    end
  end

  describe "#display_board" do
    context "when the board is empty" do
      context "when there are no misses" do
        it "prints an empty board to output" do
          board = BattleBoats::Board.new
          console_ui.display_board(board)

          expected = "-------------------------------------------------------------------\n|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n-------------------------------------------------------------------\n|  A  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |\n-------------------------------------------------------------------\n"

          expect(output.string).to include expected
        end
      end
      context "when there has been a miss" do
        it "shows the cell as having been hit" do
          board = BattleBoats::Board.new
          coordinate = BattleBoats::Coordinate.new(row: 0, column: 0)
          cell = board.cell_at(coordinate: coordinate)
          cell.strike

          console_ui.display_board(board)

          expected = "-------------------------------------------------------------------\n|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n-------------------------------------------------------------------\n|  A  |  \e[33mX\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |\n-------------------------------------------------------------------\n"

          expect(output.string).to include expected
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

          console_ui.display_board(board)

          expected = "-------------------------------------------------------------------\n|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n-------------------------------------------------------------------\n|  A  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |\n-------------------------------------------------------------------\n"

          expect(output.string).to include expected
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

        console_ui.display_board(board)

        expected = "-------------------------------------------------------------------\n|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n-------------------------------------------------------------------\n|  A  |  \e[31mF\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |\n-------------------------------------------------------------------\n"

        expect(output.string).to include expected
      end
    end
  end

  describe "#get_coordinate" do
    context "when the coordinate input is valid" do
      it "returns a coordinate based on user input" do
        valid_input = "A1"
        input = StringIO.new("#{valid_input}\n")
        console_ui = BattleBoats::ConsoleUI.new(output: output, input: input)

        result = console_ui.get_coordinate

        expect(output.string).to include("coordinate")
        expect(result.row).to eq(0)
        expect(result.column).to eq(1)
      end
    end
    context "when the coordinate input is invalid" do
      it "prompts the user again for a coordinate" do
        invalid_input = "A11"
        valid_input = "A1"
        input = StringIO.new("#{invalid_input}\n#{valid_input}")
        console_ui = BattleBoats::ConsoleUI.new(output: output, input: input)

        console_ui.get_coordinate

        expect(output.string).to include("invalid")
      end
    end
  end

  describe "#get_orientation" do
    context "when the orientation input is valid" do
      context "when the input is horizontal" do
        it "returns a horizontal symbol" do
          horizontal_input = "h"
          input = StringIO.new(horizontal_input.to_s)
          console_ui = BattleBoats::ConsoleUI.new(output: output, input: input)

          result = console_ui.get_orientation

          expect(output.string.downcase).to include("orientation")
          expect(result).to eq(:horizontal)
        end
      end
      context "when the input is vertical" do
        it "returns a vertical symbol" do
          vertical_input = "v"
          input = StringIO.new(vertical_input.to_s)
          console_ui = BattleBoats::ConsoleUI.new(output: output, input: input)

          result = console_ui.get_orientation

          expect(output.string.downcase).to include("orientation")
          expect(result).to eq(:vertical)
        end
      end
    end
    context "when the orientation input is invalid" do
      it "prompts the user again for an orientation" do
        invalid_input = "foo"
        valid_input = "h"
        input = StringIO.new("#{invalid_input}\n#{valid_input}")
        console_ui = BattleBoats::ConsoleUI.new(output: output, input: input)

        console_ui.get_orientation

        expect(output.string.downcase).to include("invalid")
      end
    end
  end

  describe "#display_status_report" do
    it "displays the given status report to the output" do
      status_report = "STATUS REPORT"

      console_ui.display_status_report(status_report)

      expect(output.string).to include(status_report)
    end
  end

  describe "#win" do
    it 'displays a "you won" message' do
      console_ui.win

      expect(output.string).to include("won")
    end
  end
end

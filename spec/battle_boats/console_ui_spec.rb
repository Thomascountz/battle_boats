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
    it "outputs result from board formatter" do
      board_formatter = instance_double(BattleBoats::BoardFormatter)
      output = StringIO.new
      board = instance_double(BattleBoats::Board)
      board_string = "board string"
      console_ui = BattleBoats::ConsoleUI.new(output: output,
                                              board_formatter: board_formatter)

      allow(board_formatter).to receive(:format_board).with(board).and_return(board_string)

      console_ui.display_board(board)

      expect(output.string).to include board_string
    end
  end

  describe "#display_ally_board" do
    it "outputs result from board formatter" do
      board_formatter = instance_double(BattleBoats::BoardFormatter)
      output = StringIO.new
      board = instance_double(BattleBoats::Board)
      board_string = "board string"
      console_ui = BattleBoats::ConsoleUI.new(output: output,
                                              board_formatter: board_formatter)

      allow(board_formatter).to receive(:format_board).with(board, enemy: false).and_return(board_string)

      console_ui.display_ally_board(board)

      expect(output.string).to include board_string
    end
  end

  describe "#display_ship_data" do
    it "outputs information about the given ship" do
      name = "Ship"
      length = 4
      symbol = "S"
      ship = BattleBoats::Ship.new(name: name, length: length, symbol: symbol)

      console_ui.display_ship_data(ship: ship)

      expect(output.string).to include(name, length.to_s, symbol)
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

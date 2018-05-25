require "battle_boats/console_ui"
require "battle_boats/board"

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
    it "prints the board to output" do
      board = BattleBoats::Board.new
      console_ui.display_board(board)

      expected = "-------------------------------------------------------------------\n|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n-------------------------------------------------------------------\n|  A  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |  \e[34m~\e[0m  |\n-------------------------------------------------------------------\n"

      expect(output.string).to include expected
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

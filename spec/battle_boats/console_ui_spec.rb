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

      expected = "-------------------------------------------------------------------\n|     |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |\n-------------------------------------------------------------------\n|  0  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |\n-------------------------------------------------------------------\n|  1  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |\n-------------------------------------------------------------------\n|  2  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |\n-------------------------------------------------------------------\n|  3  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |\n-------------------------------------------------------------------\n|  4  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |\n-------------------------------------------------------------------\n|  5  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |\n-------------------------------------------------------------------\n|  6  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |\n-------------------------------------------------------------------\n|  7  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |\n-------------------------------------------------------------------\n|  8  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |\n-------------------------------------------------------------------\n|  9  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |  \e[34m.\e[0m  |\n-------------------------------------------------------------------\n"

      expect(output.string).to eq expected
    end
  end

  describe "#get_coordinate" do
    it "returns a coordinate based on user input" do
      input = StringIO.new("4\n3\n")
      console_ui = BattleBoats::ConsoleUI.new(output: output, input: input)

      result = console_ui.get_coordinate

      expect(output.string).to include("row", "column")
      expect(result.row).to eq("4")
      expect(result.column).to eq("3")
    end
  end

  describe "#display_status_report" do
    it "displays the given status report to the output" do
      status_report = "STATUS REPORT"

      console_ui.display_status_report(status_report)

      expect(output.string).to include(status_report)
    end
  end

  describe "#display_errors" do
    it "displays the given errors to the output" do
      errors = ["error_01", "error_02"]

      console_ui.display_errors(errors)

      expect(output.string).to include("error_01", "error_02")
    end
  end
end

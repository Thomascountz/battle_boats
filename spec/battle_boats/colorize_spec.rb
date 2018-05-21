require "battle_boats/colorize"

using BattleBoats::Colorize

RSpec.describe "BattleBoats::Colorize" do
  describe "#blue" do
    it "wraps the string in the ANSI code to output it as blue" do
      string = "hello"

      result = string.blue

      expect(result).to eq("\e[34mhello\e[0m")
    end
  end

  describe "#red" do
    it "wraps the string in the ANSI code to output it as red" do
      string = "hello"

      result = string.red

      expect(result).to eq("\e[31mhello\e[0m")
    end
  end

  describe "#yellow" do
    it "wraps the string in the ANSI code to output it as yellow" do
      string = "hello"

      result = string.yellow

      expect(result).to eq("\e[33mhello\e[0m")
    end
  end
end

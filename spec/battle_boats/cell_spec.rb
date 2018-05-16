require 'battle_boats/cell'
require 'battle_boats/ship'

RSpec.describe BattleBoats::Cell do

  context 'when a new cell is initialized' do
    describe '#hit?' do
      it 'returns false by default' do
        cell = BattleBoats::Cell.new
        expect(cell.hit?).to be false
      end
    end
  end

  describe '#stike' do
    context 'when a cell is not hit' do
      it 'sets hit? to true' do
        cell = BattleBoats::Cell.new
        cell.strike
        expect(cell.hit?).to be true
      end
    end
    context 'when a cell has already been hit' do
      it 'returns nil' do
        cell = BattleBoats::Cell.new
        cell.strike
        expect(cell.strike).to be nil
      end
    end
  end

  describe '#to_s' do
    context 'when a cell is not hit' do
      it "returns the string representation of an un-hit cell" do
        cell = BattleBoats::Cell.new
        expect(cell.to_s).to eq "."
      end
    end

    context 'when a cell has been struck' do
      it "returns the string representation of a hit cell" do
        cell = BattleBoats::Cell.new
        cell.strike
        expect(cell.to_s).to eq "X"
      end
    end
  end

  describe '#occupant' do
    context 'when initialized' do
      it 'defaults to return nil' do
        cell = BattleBoats::Cell.new

        expect(cell.occupant).to eq nil
      end
    end
  end

  describe '#status_report' do
    context 'when unhit' do
      it 'returns an "all clear" message' do
        cell = BattleBoats::Cell.new

        expect(cell.status_report.downcase).to include("clear")
      end
    end
    context 'when struck' do
      context 'without an occupant' do
        it 'returns a "miss" message' do
          cell = BattleBoats::Cell.new
          cell.occupant = nil
          cell.strike

          expect(cell.status_report.downcase).to include("hit", "nothing")
        end
      end
      context 'with an occupant' do
        it 'returns a "hit" message' do
          cell = BattleBoats::Cell.new
          cell.occupant = BattleBoats::Ship.new(name: "Ship", length: 1)
          cell.strike

          expect(cell.status_report.downcase).to include("hit", "my", "ship")
        end
      end
    end
  end
end

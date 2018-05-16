require 'battle_boats/cell'

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
end

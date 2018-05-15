require 'battle_boats/cell'

RSpec.describe BattleBoats::Cell do

  subject(:cell) { described_class.new }

  describe '#to_s' do
      context 'when the cell is unhit' do
        it 'returns the string representation of an unhit cell' do
          expect(cell.to_s).to eq(".")
      end
    end
  end
end

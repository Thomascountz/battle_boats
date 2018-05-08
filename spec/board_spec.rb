require 'battle_boats/board'

RSpec.describe BattleBoats::Board do

  subject(:board) { described_class.new }

  describe '#play_area' do
    context 'when initialized' do
      it 'is a 10x10 Array of Arrays' do
        expect(board.play_area).to be_a Array
        expect(board.play_area.first).to be_a Array
        expect(board.play_area.first.length).to be 10
        expect(board.play_area.flatten.length).to be 100
      end
    end
  end
end

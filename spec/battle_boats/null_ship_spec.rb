require 'battle_boats/null_ship'

RSpec.describe BattleBoats::NullShip do
  describe '#name' do
    it 'returns the name' do
      ship = BattleBoats::NullShip.new

      expect(ship.name).to eq "nothing"
    end
  end
  describe '#length' do
    it 'returns the length' do
      ship = BattleBoats::NullShip.new

      expect(ship.length).to eq 1
    end
  end
end

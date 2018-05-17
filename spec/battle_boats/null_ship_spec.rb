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
  describe '#symbol' do
    it 'returns the symbol of a null ship' do
      ship = BattleBoats::NullShip.new

      expect(ship.symbol).to eq 'X'
    end
  end
  describe '#empty?' do
    it 'returns true' do
      ship = BattleBoats::NullShip.new

      expect(ship).to be_empty
    end
  end
end

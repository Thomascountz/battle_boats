require 'battle_boats/ship'

RSpec.describe BattleBoats::Ship do
  describe '#name' do
    it 'returns the name' do
      name = "Patrol Boat"
      ship = BattleBoats::Ship.new(name: name, length: nil)

      expect(ship.name).to eq name
    end
  end
  describe '#length' do
    it 'returns the length' do
      length = 10
      ship = BattleBoats::Ship.new(name: nil, length: length)

      expect(ship.length).to eq length
    end
  end
end

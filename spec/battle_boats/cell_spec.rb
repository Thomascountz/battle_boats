require "battle_boats/cell"
require "battle_boats/ship"
require "battle_boats/null_ship"

RSpec.describe BattleBoats::Cell do
  context "when a new cell is initialized" do
    describe "#hit?" do
      it "returns false by default" do
        cell = BattleBoats::Cell.new
        expect(cell.hit?).to be false
      end
    end
  end

  describe "#stike" do
    context "when a cell is not hit" do
      it "sets hit? to true" do
        cell = BattleBoats::Cell.new
        cell.strike
        expect(cell.hit?).to be true
      end
    end
    context "when a cell has already been hit" do
      it "returns nil" do
        cell = BattleBoats::Cell.new
        cell.strike
        expect(cell.strike).to be nil
      end
    end
  end

  describe "#occupant" do
    context "when initialized" do
      it "defaults to be a null ship" do
        cell = BattleBoats::Cell.new

        expect(cell.occupant).to be_instance_of BattleBoats::NullShip
      end
    end
  end

  describe "#status_report" do
    context "when a cell has been struck" do
      context "without an occupant" do
        it 'returns a "miss" message' do
          cell = BattleBoats::Cell.new
          cell.occupant = BattleBoats::NullShip.new
          cell.strike

          expect(cell.status_report.downcase).to include("hit", "nothing")
        end
      end
      context "with an occupant" do
        context "when the hit does not result in a sink" do
          it 'returns a "hit" message' do
            cell = BattleBoats::Cell.new
            cell.occupant = BattleBoats::Ship.new(name: "Ship", length: 2)
            cell.strike

            expect(cell.status_report.downcase).to include("hit", "my", "ship")
          end
        end
        context "when the hit results in a sink" do
          it 'returns a "sunk" message' do
            cell = BattleBoats::Cell.new
            cell.occupant = BattleBoats::Ship.new(name: "Ship", length: 1)
            cell.strike

            expect(cell.status_report.downcase).to include("sunk", "my", "ship")
          end
        end
      end
    end
  end

  describe "#occupied?" do
    context "when the occupant is a ship" do
      it "returns true" do
        cell = BattleBoats::Cell.new
        cell.occupant = BattleBoats::Ship.new(name: "Ship", length: 1)

        expect(cell).to be_occupied
      end
    end
    context "when the occupant is a null ship" do
      it "returns false" do
        cell = BattleBoats::Cell.new
        cell.occupant = BattleBoats::NullShip.new

        expect(cell).to_not be_occupied
      end
    end
  end
end

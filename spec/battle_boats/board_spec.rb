require "battle_boats/board"
require "battle_boats/cell"
require "battle_boats/ship"
require "battle_boats/coordinate"

RSpec.describe BattleBoats::Board do
  subject(:board) { described_class.new }

  describe "#play_area" do
    context "when initialized" do
      it "is a 10x10 Array of Arrays" do
        expect(board.play_area).to be_a Array
        expect(board.play_area.first).to be_a Array
        expect(board.play_area.first.length).to be 10
        expect(board.play_area.flatten.length).to be 100
      end
      it "is made up of unique Cell objects" do
        expect(board.play_area.flatten).to_not be_empty
        expect(board.play_area.flatten).to all be_instance_of BattleBoats::Cell
        expect(board.play_area.flatten.length).to eq(board.play_area.flatten.uniq.length)
      end
    end
  end

  describe "#place_ships_randomly" do
    it "randomly places each ship in fleet in the play area" do
      fleet = BattleBoats::Fleet.new
      expected_cells_with_ships = fleet.ships.sum(&:length)
      board = BattleBoats::Board.new(fleet: fleet)

      board.place_ships_randomly

      cells_with_ships = board.play_area.flatten.count(&:occupied?)

      expect(cells_with_ships).to eq expected_cells_with_ships
    end
  end

  describe "#strike_position" do
    context "when the row and column are valid positions in the play area" do
      context "when the cell at the coordinate does not contain a ship" do
        it "it strikes the cell and updates the status report" do
          row = 1
          column = 1
          coordinate = BattleBoats::Coordinate.new(row: row, column: column)

          result = board.strike_position(coordinate: coordinate)

          expect(result).to eq true
          expect(board.cell_at(coordinate: coordinate)).to be_hit
          expect(board.status_report.downcase).to include("hit", "nothing")
        end
      end

      context "when the cell has already been hit" do
        it 'updates the status report include an "already hit" statement' do
          row = 1
          column = 1
          coordinate = BattleBoats::Coordinate.new(row: row, column: column)

          board.strike_position(coordinate: coordinate)
          result = board.strike_position(coordinate: coordinate)

          expect(result).to eq false
          expect(board.status_report).to include("That position has already been hit")
        end
      end
    end
  end

  describe "#game_over?" do
    context "when all ships in the fleet have not been sunk" do
      it "returns false" do
        expect(board.game_over?).to eq false
      end
    end
    context "when all ships in the fleet have been sunk" do
      it "returns true" do
        board.fleet.ships.each do |ship|
          sink_ship(ship)
        end
        expect(board.game_over?).to eq true
      end
    end
  end

  describe "#cell_at" do
    context "when the row and column are within the play area" do
      it "returns the cell located at that row and column" do
        row = 3
        column = 4
        coordinate = BattleBoats::Coordinate.new(row: row, column: column)

        expect(board.cell_at(coordinate: coordinate)).to be board.play_area[row][column]
      end
    end
    context "when the row and column are not within the play area" do
      it "returns nil" do
        row = 8008
        column = 4
        coordinate = BattleBoats::Coordinate.new(row: row, column: column)

        expect(board.cell_at(coordinate: coordinate)).to eq nil
      end
    end
    context "when the row is negative" do
      it "returns nil" do
        row = -1
        column = 4
        coordinate = BattleBoats::Coordinate.new(row: row, column: column)

        expect(board.cell_at(coordinate: coordinate)).to eq nil
      end
    end
    context "when the column is negative" do
      it "returns nil" do
        row = 6
        column = -1
        coordinate = BattleBoats::Coordinate.new(row: row, column: column)

        expect(board.cell_at(coordinate: coordinate)).to eq nil
      end
    end
  end

  describe "#place_ship_horizontally" do
    context "when the given ship fits at the given position" do
      it "places the ship on the board, moving from left to right, based on the ship length" do
        ship = BattleBoats::Ship.new(name: "Submarine", length: 3, symbol: "S")
        row = 0
        column = 0
        coordinate = BattleBoats::Coordinate.new(row: row, column: column)

        board.place_ship_horizontally(coordinate: coordinate, ship: ship)

        expect(board.cell_at(coordinate: coordinate).occupant).to be ship
        expect(board.cell_at(coordinate: coordinate).occupant).to be ship
        expect(board.cell_at(coordinate: coordinate).occupant).to be ship
      end
    end
    context "when the given ship does not fit at the given position" do
      it "returns false" do
        ship = BattleBoats::Ship.new(name: "Submarine", length: 3, symbol: "S")
        row = 0
        column = 9
        coordinate = BattleBoats::Coordinate.new(row: row, column: column)

        board.place_ship_horizontally(coordinate: coordinate, ship: ship)

        expect(board.cell_at(coordinate: coordinate).occupant).to_not be ship
      end
    end
    context "when a ship would occupy a cell that already contains a ship" do
      it "returns false" do
        ship = BattleBoats::Ship.new(name: "Submarine", length: 3, symbol: "S")
        ship2 = BattleBoats::Ship.new(name: "Destroyer", length: 2, symbol: "D")
        row = 0
        column = 0
        coordinate = BattleBoats::Coordinate.new(row: row, column: column)

        board.place_ship_horizontally(coordinate: coordinate, ship: ship)

        board.place_ship_horizontally(coordinate: coordinate, ship: ship2)

        expect(board.cell_at(coordinate: coordinate).occupant).to be ship
        expect(board.cell_at(coordinate: coordinate).occupant).to_not be ship2
      end
    end
  end
  describe "#place_ship_vertically" do
    context "when the given ship fits at the given position" do
      it "places the ship on the board, bottom to top, based on the ship length" do
        ship = BattleBoats::Ship.new(name: "Submarine", length: 3, symbol: "S")
        row = 9
        column = 9
        coordinate = BattleBoats::Coordinate.new(row: row, column: column)

        board. place_ship_vertically(coordinate: coordinate, ship: ship)

        expect(board.cell_at(coordinate: coordinate).occupant).to be ship
        expect(board.cell_at(coordinate: coordinate).occupant).to be ship
        expect(board.cell_at(coordinate: coordinate).occupant).to be ship
      end
    end
    context "when the given ship does not fit at the given position" do
      it "returns false" do
        ship = BattleBoats::Ship.new(name: "Submarine", length: 3, symbol: "S")
        row = 0
        column = 9
        coordinate = BattleBoats::Coordinate.new(row: row, column: column)

        board.place_ship_vertically(coordinate: coordinate, ship: ship)

        expect(board.cell_at(coordinate: coordinate).occupant).to_not be ship
      end
    end
    context "when a ship would occupy a cell that already contains a ship" do
      it "returns false" do
        ship = BattleBoats::Ship.new(name: "Submarine", length: 3, symbol: "S")
        ship2 = BattleBoats::Ship.new(name: "Destroyer", length: 2, symbol: "D")
        row = 9
        column = 9
        coordinate = BattleBoats::Coordinate.new(row: row, column: column)

        board.place_ship_vertically(coordinate: coordinate, ship: ship)

        board.place_ship_vertically(coordinate: coordinate, ship: ship2)

        expect(board.cell_at(coordinate: coordinate).occupant).to be ship
        expect(board.cell_at(coordinate: coordinate).occupant).to_not be ship2
      end
    end
  end
  def sink_ship(ship)
    ship.length.times do
      ship.hit
    end
  end
end

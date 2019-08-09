require "battle_maker"

RSpec.describe BattleMaker do
  context "given a battle with no walls" do
    let(:battle) do
      BattleMaker::make(
        [
          "_____",
          "_____",
          "0___1",
          "_____",
          "__2__",
        ],
        {
          0 => { rotation: 0 },
          1 => { rotation: 180 },
        }
      )
    end

    it "shows all players" do
      expect(battle.robots.length).to be(3)
    end

    it "makes a battle" do
      # Board is right size
      expect(battle.board.width).to eq(5)
      expect(battle.board.height).to eq(5)

      # Robots get right position and override rotation
      expect(battle.robots[0].rotation).to eq(0)
      expect(battle.robots[0].x).to eq(0)
      expect(battle.robots[0].y).to eq(2)

      expect(battle.robots[1].rotation).to eq(180)
      expect(battle.robots[1].x).to eq(4)
      expect(battle.robots[1].y).to eq(2)

      expect(battle.robots[2].rotation).to eq(0)
      expect(battle.robots[2].x).to eq(2)
      expect(battle.robots[2].y).to eq(0)
    end
  end

  context "given a battle with a wall" do
    let(:battle) do
      BattleMaker::make(
        [
          "_____",
          "_____",
          "0_x_1",
          "_____",
          "__2__",
        ],
        {
          0 => { rotation: 0 },
          1 => { rotation: 180 },
        }
      )
    end

    it "doesn't include the hidden player hidden from robot 0" do
      expect(battle.robots.length).to be(2)

      expect(battle.robots[1].x).to eq(2)
      expect(battle.robots[1].y).to eq(0)
    end

    it "includes the walls" do
      expect(battle.board.walls.length).to be(1)
      expect(battle.board.walls[0].x).to be(2)
      expect(battle.board.walls[0].y).to be(2)
    end
  end
end

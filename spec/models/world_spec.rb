require './lib/models/slot'
require './lib/models/world'

describe World do
  let(:world){ World.new([10, 10], [[1,1], [2,2], [3,3]]) }
  let(:slot){ Slot.new(world, 1, 1, false) }

  describe "#initialize" do
    it "generates slots by coordinates count" do
      expect(world.slots.count).to eq 3
    end
  end

  describe "#make_step" do
    it "calls generate_next method on live slots" do
      expect(world.slots[0]).to receive(:generate_next)
      world.make_step
    end

    it "creates dead slots" do
      expect(Slot).to receive(:new).and_return(slot).exactly(9).times
      World.new([3, 3], []).make_step
    end
  end

  describe "#get_slot" do
    it "returns slot if exists" do
      expect(world.get_slot(1, 1)).to eq world.slots[0]
    end

    it "returns nil otherwise" do
      expect(world.get_slot(0, 0)).to eq nil
    end
  end

  describe "#add_slot" do
    it "adds new slot to list" do
      expect{
        world.add_slot(4, 4)
      }.to change(world.slots, :count).by(1)
    end
  end
end

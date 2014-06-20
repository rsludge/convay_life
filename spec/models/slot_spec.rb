require './lib/models/slot'
require './lib/models/world'

describe Slot do
  let(:world){ World.new([10, 10], []) }
  let(:slot){ Slot.new(world, 2, 2, true) }

  before :each do
    world.slots << slot
  end

  context "alive slot" do
    it "is alive in next generation if have 2 neighbours" do
      allow(slot).to receive(:neighbours_count).and_return(2)
      expect(slot.alive_next).to be true
    end

    it "is alive in next generation if have 3 neighbours" do
      allow(slot).to receive(:neighbours_count).and_return(3)
      expect(slot.alive_next).to be true
    end

    it "is dead if have less than 2 neighbours" do
      allow(slot).to receive(:neighbours_count).and_return(1)
      expect(slot.alive_next).to be false
    end

    it "is dead if have more than 3 neighbours" do
      allow(slot).to receive(:neighbours_count).and_return(4)
      expect(slot.alive_next).to be false
    end
  end

  context "dead cell" do
    before :each do
      slot.alive = false
    end

    it "is alive if have more 3 neighbours" do
      allow(slot).to receive(:neighbours_count).and_return(3)
      expect(slot.alive_next).to be true
    end

    it "is dead otherwise" do
      allow(slot).to receive(:neighbours_count).and_return(2)
      expect(slot.alive_next).to be false
    end
  end

  describe '#neighbours_count' do
    it "is 0 if no neighbours" do
      expect(slot.neighbours_count).to eq 0
    end

    it "recognizes 8 neighbours" do
      world.add_slot(slot.x-1, slot.y-1)
      world.add_slot(slot.x-1, slot.y)
      world.add_slot(slot.x-1, slot.y+1)
      world.add_slot(slot.x, slot.y-1)
      world.add_slot(slot.x, slot.y+1)
      world.add_slot(slot.x+1, slot.y-1)
      world.add_slot(slot.x+1, slot.y)
      world.add_slot(slot.x+1, slot.y+1)
      expect(slot.neighbours_count).to eq 8
    end
  end

  describe "#generate_next" do
    it "adds slot to next generation if it alive_next" do
      allow(slot).to receive(:alive_next).and_return true
      expect{
        slot.generate_next
      }.to change(world.next_slots, :count).by(1)
    end

    it "doesn't add slot to next generation if it not alive_next" do
      allow(slot).to receive(:alive_next).and_return false
      expect{
        slot.generate_next
      }.to_not change(world.next_slots, :count)
    end
  end
end

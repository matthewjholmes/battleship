require './lib/ship'

RSpec.describe Ship do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
  end

  it 'exists and has attributes' do
    expect(@cruiser).to be_instance_of(Ship)
    expect(@cruiser.name).to eq("Cruiser")
    expect(@cruiser.length).to eq(3)
  end

  it 'has health' do
    expect(@cruiser.health).to eq(3)
  end

  it 'is not sunk? by default' do
    expect(@cruiser.sunk?).to eq(false)
  end

  it 'reduces health with hit' do
    @cruiser.hit

    expect(@cruiser.health).to eq(2)

    @cruiser.hit

    expect(@cruiser.health).to eq(1)
  end
end

  # pry(main)> cruiser.sunk?
  # #=> false
  #
  # pry(main)> cruiser.hit
  #
  # pry(main)> cruiser.sunk?
  # #=> true

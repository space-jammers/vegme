require 'rails_helper'

describe Array do
  before :all do
    @simple = ('a'..'e').to_a
  end

  it 'should be a subset of original collection' do
    expect(@simple.paginate(1, nil, 3)).to eq(%w[a b c])
  end
end

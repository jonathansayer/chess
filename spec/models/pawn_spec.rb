require 'rails_helper'

describe Pawn do

  it 'should respond to move limit' do
    expect(subject).to respond_to :move_limit
  end

  it 'should return 1 for the move limit' do
    expect(subject.move_limit).to eq 1
  end

  it 'should respond to directions' do
    expect(subject).to respond_to :direction
  end

  it 'should respond to allowed diretions' do
    expect(subject).to respond_to :allowed_directions
  end

  it 'should be able to move forward' do
    expect(subject.direction).to eq 'forward'
  end

  # it 'should be allowed to move forward diagonally when the cell is occupied.' do
  #   subject = Pawn.create(position:'A2')
  #   to_take_pawn = Pawn.create(position: "B3")

end

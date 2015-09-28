require 'rails_helper'

describe Board do

  it 'should respond to move_piece with one argument' do
    expect(subject).to respond_to(:move_piece).with(2).argument
  end

  it 'should call the move_to method for the piece' do
    pawn = double :pawn
    expect(pawn).to receive(:move_to)
    subject.move_piece pawn, 'A3'
  end
end

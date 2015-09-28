require 'rails_helper'

describe Board do

  it 'should respond to move_piece with two arguments' do
    expect(subject).to respond_to(:move_piece).with(2).argument
  end

  it 'should call the move_to method for the piece' do
    pawn = double :pawn
    cell = double :cell
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by) {cell}
    allow(cell).to receive(:change_occupied_mode)
    expect(pawn).to receive(:move_to)
    subject.move_piece pawn, 'D5'
  end

  it 'should change the occupied state of the Cell that the piece moves to' do
    pawn = double :pawn
    allow(pawn).to receive(:move_to)
    cell = double :cell
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by) {cell}
    expect(cell).to receive(:change_occupied_mode)
    subject.move_piece pawn, 'D5'
  end

end

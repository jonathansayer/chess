require 'rails_helper'

describe Board do

  let(:pawn){double :pawn}
  let(:to_cell){double :to_cell}
  let(:from_cell){double :from_cell}

  before(:each) do
    allow(pawn).to receive(:position) {'D4'}
    allow(pawn).to receive(:move_to)
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by).with({:position=>"D5"}){to_cell}
    allow(cell_class).to receive(:find_by).with({:position=>"D4"}){from_cell}
  end

  it 'should respond to move_piece with two arguments' do
    expect(subject).to respond_to(:move_piece).with(2).argument
  end

  it 'should call the move_to method for the piece' do
    allow(from_cell).to receive(:change_occupied_mode)
    allow(to_cell).to receive(:change_occupied_mode)
    subject.move_piece pawn, 'D5'
  end

  it 'should change the occupied state of the Cell that the piece moves to' do
    allow(from_cell).to receive(:change_occupied_mode)
    expect(to_cell).to receive(:change_occupied_mode)
    subject.move_piece pawn, 'D5'
  end

  it 'should change the occupied state of the Cell that the piece move away from' do
    allow(to_cell).to receive(:change_occupied_mode)
    expect(from_cell).to receive(:change_occupied_mode)
    subject.move_piece pawn, 'D5'
  end

end

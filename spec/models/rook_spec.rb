require 'rails_helper'

describe Rook do

  before(:each) do
    subject.position = 'A1'
  end

  it 'should respond to position' do
    expect(subject).to respond_to :position
  end

  it 'should respond to move with one arguement' do
    expect(subject).to respond_to(:move_to).with(1).argument
  end

  it 'should be able to move forward one cell' do
    subject.move_to 'A2'
    expect(subject.position).to eq 'A2'
  end

  it 'should be able to move forward more than one cell' do
    cell = double :cell, occupied?: false
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by) {cell}
    subject.move_to 'A8'
    expect(subject.position).to eq 'A8'
  end

  it 'should be able to move backward one space' do
    subject.position = 'A8'
    subject.move_to 'A7'
    expect(subject.position).to eq 'A7'
  end

  it 'should be able to move backward more than one cell' do
    subject.position = 'A8'
    subject.move_to 'A1'
    expect(subject.position).to eq 'A1'
  end

  it 'should not be able to move diagonally' do
    expect{subject.move_to 'B2'}.to raise_error "Invalid Move"
  end

  it 'should be able to move horizontally one cell' do
    subject.move_to 'B1'
    expect(subject.position).to eq 'B1'
  end

  it 'should be able to move horizontally multiple cells' do
    subject.move_to 'H1'
    expect(subject.position).to eq 'H1'
  end

  it 'should not be able to continue moving horizontally once take a piece' do
    from_cell = double :from_cell, positions: 'A1', occupied?: true
    occupied_cell = double :occupied_cell, position: 'A2', occupied?: true
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by).with({:position=>"A1"}){occupied_cell}
    allow(cell_class).to receive(:find_by).with({:position=>"A2"}){occupied_cell}
    expect{subject.move_to 'A4'}.to raise_error "Invalid Move"
  end

end

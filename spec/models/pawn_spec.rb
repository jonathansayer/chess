require 'rails_helper'

describe Pawn do

  let(:subject){Pawn.create(position:'A2')}

  it 'should respond to move_forward with one argument' do
    expect(subject).to respond_to(:move_forward).with(1).argument
  end

  it 'should allow a pawn to move from A2 to A3' do
    subject.move_forward 1
    expect(subject.position).to eq 'A3'
  end

  it 'should be able to move from A2 to A4' do
    subject.move_forward 2
    expect(subject.position).to eq 'A4'
  end

  it 'should not be able to move from A3 to A5' do
    subject.position = 'A3'
    expect{subject.move_forward 2}.to raise_error "Invalid Move"
  end

  it 'should respond to move_diagonally' do
    expect(subject).to respond_to :move_diagonally
  end

  it 'should be able to move diagonally if that square is occupied' do
    cell = double cell, position: 'B3', occupied?: true
    allow(Cell).to receive(:find_by) {cell}
    subject.move_diagonally 'B3'
    expect(subject.position).to eq 'B3'
  end

  it 'should not be able to move diagonally twice to an occupied square' do
    cell = double cell, position: 'C4', occupied?: true
    allow(Cell).to receive(:find_by) {cell}
    expect{subject.move_diagonally 'C4'}.to raise_error "Invalid Move"
  end

  it 'should not be able to move diagonally if cell is not occupied' do
    cell = double cell, position: 'B3', occupied?: false
    allow(Cell).to receive(:find_by) {cell}
    expect{subject.move_diagonally 'B3'}.to raise_error "Invalid Move"
  end

end

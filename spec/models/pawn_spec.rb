require 'rails_helper'

describe Pawn do

  before(:each) do
    subject.position = 'D2'
  end

  it 'should respond to move_forward with one argument' do
    expect(subject).to respond_to(:move_to).with(1).argument
  end

  it 'should allow a pawn to move from D2 to D3' do
    cell = double cell, position: 'E3', occupied?: true
    allow(Cell).to receive(:find_by) {cell}
    subject.move_to 'D3'
    expect(subject.position).to eq 'D3'
  end

  it 'should be able to move from D2 to D4' do
    cell = double cell, position: 'E3', occupied?: true
    allow(Cell).to receive(:find_by) {cell}
    subject.move_to 'D4'
    expect(subject.position).to eq 'D4'
  end

  it 'should not be able to move from D3 to D5' do
    cell = double cell, position: 'E3', occupied?: true
    allow(Cell).to receive(:find_by) {cell}
    subject.position = 'D3'
    expect{subject.move_to 'D5'}.to raise_error "Invalid Move"
  end

  it 'should be able to move diagonally if that square is occupied' do
    cell = double cell, position: 'E3', occupied?: true
    allow(Cell).to receive(:find_by) {cell}
    subject.move_to 'E3'
    expect(subject.position).to eq 'E3'
  end

  it 'should not be able to move diagonally twice to an occupied square' do
    cell = double cell, position: 'F4', occupied?: true
    allow(Cell).to receive(:find_by) {cell}
    expect{subject.move_to 'F4'}.to raise_error "Invalid Move"
  end

  it 'should not be able to move diagonally if cell is not occupied' do
    cell = double cell, position: 'E3', occupied?: false
    allow(Cell).to receive(:find_by) {cell}
    expect{subject.move_to 'E3'}.to raise_error "Invalid Move"
  end

end

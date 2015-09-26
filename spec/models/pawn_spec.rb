require 'rails_helper'

describe Pawn do

  let(:subject){Pawn.create(position:'A2',
                            move_limit:1,
                            horizontal?: false,
                            vertical?: true,
                            diagonal?: true)}

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

  it 'should allow a pawn to move from A2 to A3' do
    subject.move_forward
    expect(subject.position).to eq 'A3'
  end

  it 'should be able to move from A2 to A4' do
    subject.move_two_squares
    expect(subject.position).to eq 'A4'
  end

  it 'should not be able to move from A3 to A5' do
    subject.position = 'A3'
    expect{subject.move_two_squares}.to raise_error "Invalid Move"
  end

  it 'should be able to move diagonally if that square is occupied' do
    cell = double :cell,position:'B3', occupied?: true
    subject.move_diagonally 'B3'
    expect(subject.position).to eq 'B3'
  end

  it 'should not be able to move diagonally twice to an occupied square' do
    cell = double :cell, position: 'C4', occupied?: true
    expect{subject.move_diagonally 'C4'}.to raise_error "Invalid Move"
  end


end

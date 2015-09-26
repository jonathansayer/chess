require 'rails_helper'

describe Pawn do

  let(:subject){Pawn.create(position:'A2',
                            move_limit:1,
                            horizontal?: false,
                            vertical?: true,
                            diagonal?: true)}

  it 'shoudl respond to move_forward' do
    expect(subject).to respond_to :move_forward
  end

  it 'should allow a pawn to move from A2 to A3' do
    subject.move_forward
    expect(subject.position).to eq 'A3'
  end

  it 'should respond to move_two_squares' do
    expect(subject).to respond_to :move_two_squares
  end

  it 'should be able to move from A2 to A4' do
    subject.move_two_squares
    expect(subject.position).to eq 'A4'
  end

  it 'should not be able to move from A3 to A5' do
    subject.position = 'A3'
    expect{subject.move_two_squares}.to raise_error "Invalid Move"
  end

  it 'should respond to move_diagonally' do
    expect(subject).to respond_to :move_diagonally
  end

  it 'should be able to move diagonally if that square is occupied' do
    Cell.create(position: "B3", occupied?: true )
    subject.move_diagonally 'B3'
    expect(subject.position).to eq 'B3'
  end

  it 'should not be able to move diagonally twice to an occupied square' do
    Cell.create(position: "C4", occupied?: true )
    expect{subject.move_diagonally 'C4'}.to raise_error "Invalid Move"
  end

  it 'should not be able to move diagonally if cell is not occupied' do
    Cell.create(position: "B3", occupied?: false )
    expect{subject.move_diagonally 'B3'}.to raise_error "Invalid Move"
  end

end

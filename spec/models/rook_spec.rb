require 'rails_helper'

describe Rook do

  let(:subject){Rook.create(position:'A1')}

  it 'should respond to position' do
    expect(subject).to respond_to :position
  end

  it 'should respond to move_vertically with one arguement' do
    expect(subject).to respond_to(:move_vertically).with(1).argument
  end

  it 'should be able to move forward one cell' do
    subject.move_vertically 'A2'
    expect(subject.position).to eq 'A2'
  end

  it 'should be able to move forward more than one cell' do
    subject.move_vertically 'A8'
    expect(subject.position).to eq 'A8'
  end

  it 'should be able to move backward one space' do
    subject.position = 'A8'
    subject.move_vertically 'A7'
    expect(subject.position).to eq 'A7'
  end

  it 'should be able to move backward more than one space' do
    subject.position = 'A8'
    subject.move_vertically 'A1'
    expect(subject.position).to eq 'A1'
  end

  it 'should not be able to move diagonally' do
    expect{subject.move_vertically 'B2'}.to raise_error "Invalid Move"
  end

  it 'should be able to move horizontally with one argument' do
    expect(subject).to respond_to(:move_horizontally).with(1).argument
  end

  it 'should be able to move horizontally one cell' do
    subject.move_horizontally 'B1'
    expect(subject.position).to eq 'B1'
  end

  it 'should be able to move horizontally multiple cells' do
    subject.move_horizontally 'H1'
    expect(subject.position).to eq 'H1'
  end

  it 'should not be allowd to move diagonally using horizontal method' do
    expect{subject.move_horizontally 'B2'}.to raise_error "Invalid Move"
  end 

end

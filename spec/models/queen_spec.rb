require 'rails_helper'

describe Queen do

  before(:each) do
    subject.position = 'D4'
  end

  it 'should have a position' do
    expect(subject).to respond_to :position
  end

  it 'should respond to move_to with one argument' do
    expect(subject).to respond_to(:move_to).with(1).argument
  end

  it 'should be able to move forward by one square (from D4 to D5)' do
    subject.move_to 'D5'
    expect(subject.position).to eq 'D5'
  end

  it 'should be able to move backward by one square (from D4 to D3)' do
    subject.move_to 'D3'
    expect(subject.position).to eq'D3'
  end

  it 'should be able to move to the right by one square (from D4 to C4)' do
    subject.move_to 'C4'
    expect(subject.position).to eq 'C4'
  end

  it 'should be able to move to the left by one square (from D4 to E4)' do
    subject.move_to 'E4'
    expect(subject.position).to eq 'E4'
  end

  it 'should be able to move diagonally forward-right by one (from D4 to E5)' do
    subject.move_to 'E5'
    expect(subject.position).to eq 'E5'
  end

  it 'should be able to move diagonally forward-left by one (from D4 to C5)' do
    subject.move_to 'C5'
    expect(subject.position).to eq 'C5'
  end

  it 'should be able to move diagonally backward-right by one (from D4 to E3)' do
    subject.move_to 'E3'
    expect(subject.position).to eq 'E3'
  end

  it 'should be able to move diagonally backward-left by one (from D4 to C3)' do
    subject.move_to 'C3'
    expect(subject.position).to eq 'C3'
  end 


end

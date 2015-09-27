require 'rails_helper'

describe Bishop do

  it 'should respond to position' do
    expect(subject).to respond_to :position
  end

  it 'should respond to move_to with one argument' do
    expect(subject).to respond_to(:move_to).with(1).argument
  end

  context "when moving diagonally" do

    before(:each) do
      subject.position = 'D4'
    end

    it 'should be able to move diagonally forward-right by 1(from D4 to E5)' do
      subject.move_to 'E5'
      expect(subject.position).to eq 'E5'
    end

    it 'should be able to move diagonally forward-left by 1(from D4 to C5)' do
      subject.move_to 'C5'
      expect(subject.position).to eq 'C5'
    end

    it 'should be able to move diagonally backwards-right by 1(from D4 to E3)' do
      subject.move_to 'E3'
      expect(subject.position).to eq 'E3'
    end

    it 'should be able to move diagonally backwwards-left by 1(from D4 to C3)' do
      subject.move_to 'C3'
      expect(subject.position).to eq 'C3'
    end

  end

end

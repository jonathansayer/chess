require 'rails_helper'

describe Bishop do

  it 'should respond to position' do
    expect(subject).to respond_to :position
  end

  it 'should respond to move_to with one argument' do
    expect(subject).to respond_to(:move_to).with(1).argument
  end

  context "when moving diagonally" do

    it 'should be able to move diagonally forward-right by 1(from D4 to E5)' do
      subject.position = 'D4'
      subject.move_to 'E5'
      expect(subject.position).to eq 'E5'
    end
  end

end

require 'rails_helper'

describe King do

  before(:each) do
    subject.position = 'D4'
  end

  it 'should respond to position' do
    expect(subject).to respond_to :position
  end

  it 'should respond to move_to with one arguement' do
    expect(subject).to respond_to(:move_to).with(1).argument
  end

  it 'should be able to move forward by from D4 to D5' do
    subject.move_to 'D5'
    expect(subject.position).to eq 'D5'
  end

  it 'should be able to move backwards by one' do
    subject.move_to "D3"
    expect(subject.position).to eq "D3"
  end

  it 'should be able to move right by one' do
    subject.move_to "E4"
    expect(subject.position).to eq "E4"
  end

  it 'should be able to move left by one' do
    subject.move_to "D4"
    expect(subject.position).to eq "D4"
  end

  it 'should be able to move diagonally forward-right by one(from D4 to E5)' do
    subject.move_to "E5"
    expect(subject.position).to eq "E5"
  end

  it 'should be able to move diagonally forward-left by one(from D4 to C5)' do
    subject.move_to "C5"
    expect(subject.position).to eq "C5"
  end

  it 'should be able to move diagonally backward-right by one(from D4 to E3)' do
    subject.move_to "E3"
    expect(subject.position).to eq "E3"
  end

  it 'should be able to move diagonally backward-left by one(from D4 to C3)' do
    subject.move_to "C3"
    expect(subject.position).to eq "C3"
  end

  context "when trying to make an invalid move" do

    it 'should not be able to move to E6 from D4' do
      expect{subject.move_to 'E6'}.to raise_error "Invalid Move"
    end

    it 'cannot move more than one place forward ( from D4 to D6 )' do
      expect{subject.move_to 'D6'}.to raise_error "Invalid Move"
    end

    it 'cannot move more than one place backward (from D4 to D2)' do
      expect{subject.move_to 'D2'}.to raise_error "Invalid Move"
    end

    it 'cannot move more than one place right (from D4 to F4)' do
      expect{subject.move_to 'F4'}.to raise_error "Invalid Move"
    end

    it 'cannot move more than one place left (from D4 to B4)' do
      expect{subject.move_to 'B4'}.to raise_error "Invalid Move"
    end

    it 'cannot more more than one place diagonally forward-right (from D4 to F6)' do
      expect{subject.move_to 'F6'}.to raise_error "Invalid Move"
    end

    it 'cannot more more than one place diagonally forward-left (from D4 to B6)' do
      expect{subject.move_to 'B6'}.to raise_error "Invalid Move"
    end

    it 'cannot more more than one place diagonally backward-right (from D4 to F2)' do
      expect{subject.move_to 'F2'}.to raise_error "Invalid Move"
    end

    it 'cannot more more than one place diagonally backward-left (from D4 to B2)' do
      expect{subject.move_to 'B2'}.to raise_error "Invalid Move"
    end
  end
end

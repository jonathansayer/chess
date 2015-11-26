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

  it 'should be able to move forward by 1 from D4 to D5' do
    convert_class = class_double('ConvertCoordinates').as_stubbed_const
    allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
    allow(convert_class).to receive(:to_numerical_coords).with('D5'){[4,5]}
    subject.move_to 'D5'
    expect(subject.position).to eq 'D5'
  end

  it 'should be able to move backwards by one' do
    convert_class = class_double('ConvertCoordinates').as_stubbed_const
    allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
    allow(convert_class).to receive(:to_numerical_coords).with('D3'){[4,3]}
    subject.move_to "D3"
    expect(subject.position).to eq "D3"
  end

  it 'should be able to move right by one' do
    convert_class = class_double('ConvertCoordinates').as_stubbed_const
    allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
    allow(convert_class).to receive(:to_numerical_coords).with('E4'){[5,4]}
    subject.move_to "E4"
    expect(subject.position).to eq "E4"
  end

  it 'should be able to move left by one' do
    convert_class = class_double('ConvertCoordinates').as_stubbed_const
    allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
    allow(convert_class).to receive(:to_numerical_coords).with('C4'){[3,4]}
    subject.move_to "C4"
    expect(subject.position).to eq "C4"
  end

  it 'should be able to move diagonally forward-right by one(from D4 to E5)' do
    convert_class = class_double('ConvertCoordinates').as_stubbed_const
    allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
    allow(convert_class).to receive(:to_numerical_coords).with('E5'){[5,5]}
    subject.move_to "E5"
    expect(subject.position).to eq "E5"
  end

  it 'should be able to move diagonally forward-left by one(from D4 to C5)' do
    convert_class = class_double('ConvertCoordinates').as_stubbed_const
    allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
    allow(convert_class).to receive(:to_numerical_coords).with('C5'){[3,5]}
    subject.move_to "C5"
    expect(subject.position).to eq "C5"
  end

  it 'should be able to move diagonally backward-right by one(from D4 to E3)' do
    convert_class = class_double('ConvertCoordinates').as_stubbed_const
    allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
    allow(convert_class).to receive(:to_numerical_coords).with('E3'){[5,3]}
    subject.move_to "E3"
    expect(subject.position).to eq "E3"
  end

  it 'should be able to move diagonally backward-left by one(from D4 to C3)' do
    convert_class = class_double('ConvertCoordinates').as_stubbed_const
    allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
    allow(convert_class).to receive(:to_numerical_coords).with('C3'){[3,3]}
    subject.move_to "C3"
    expect(subject.position).to eq "C3"
  end

  context "when trying to make an invalid move" do

    it 'should not be able to move to E6 from D4' do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('E6'){[5,6]}
      expect{subject.move_to 'E6'}.to raise_error "Invalid Move"
    end

    it 'cannot move more than one place forward ( from D4 to D6 )' do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('D6'){[4,6]}
      expect{subject.move_to 'D6'}.to raise_error "Invalid Move"
    end

    it 'cannot move more than one place backward (from D4 to D2)' do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('D2'){[4,2]}
      expect{subject.move_to 'D2'}.to raise_error "Invalid Move"
    end

    it 'cannot move more than one place right (from D4 to F4)' do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('F4'){[6,4]}
      expect{subject.move_to 'F4'}.to raise_error "Invalid Move"
    end

    it 'cannot move more than one place left (from D4 to B4)' do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('B4'){[2,4]}
      expect{subject.move_to 'B4'}.to raise_error "Invalid Move"
    end

    it 'cannot more more than one place diagonally forward-right (from D4 to F6)' do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('F6'){[6,6]}
      expect{subject.move_to 'F6'}.to raise_error "Invalid Move"
    end

    it 'cannot more more than one place diagonally forward-left (from D4 to B6)' do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('B6'){[2,6]}
      expect{subject.move_to 'B6'}.to raise_error "Invalid Move"
    end

    it 'cannot more more than one place diagonally backward-right (from D4 to F2)' do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('F2'){[6,2]}
      expect{subject.move_to 'F2'}.to raise_error "Invalid Move"
    end

    it 'cannot more more than one place diagonally backward-left (from D4 to B2)' do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('B2'){[2,2]}
      expect{subject.move_to 'B2'}.to raise_error "Invalid Move"
    end
  end

  it 'should be able to list all possible moves?' do
    expect(subject.all_possible_moves).to eq ['C3','D3','E3','C4','E4', 'C5','D5','E5']
  end
end

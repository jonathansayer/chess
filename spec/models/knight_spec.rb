require 'rails_helper'

describe Knight do

  before(:each) do
    subject.position = 'D4'
    convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
    allow(convert_class).to receive(:to_numerical_coords).with('B3'){[2,3]}
    allow(convert_class).to receive(:to_numerical_coords).with('B5'){[2,5]}
    allow(convert_class).to receive(:to_numerical_coords).with('C6'){[3,6]}
    allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
    allow(convert_class).to receive(:to_numerical_coords).with('F5'){[6,5]}
    allow(convert_class).to receive(:to_numerical_coords).with('E4'){[5,4]}
    allow(convert_class).to receive(:to_numerical_coords).with('E6'){[5,6]}
  end

  it 'should respond to position' do
    expect(subject).to respond_to :position
  end

  it 'should respond to move_to with one arguement' do
    expect(subject).to respond_to(:move_to).with(1).argument
  end

  it 'should be able to move from D4 to E6' do
    subject.move_to 'E6'
    expect(subject.position).to eq 'E6'
  end

  it 'should be able to move from D4 to F5' do
    subject.move_to 'F5'
    expect(subject.position).to eq 'F5'
  end

  it 'should be able to move from D4 tp B3' do
    subject.move_to 'B3'
    expect(subject.position).to eq 'B3'
  end

  it 'should be able to move from D4 to B5' do
    subject.move_to 'B5'
    expect(subject.position).to eq 'B5'
  end

  it 'should be able to move from D4 to C6' do
    subject.move_to 'C6'
    expect(subject.position).to eq 'C6'
  end

  context "when trying to make an invalid move" do

    it 'should not be able to move from D4 to E4' do
      expect{subject.move_to 'E4'}.to raise_error 'Invalid Move'
    end
  end

end

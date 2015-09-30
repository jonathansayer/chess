require 'rails_helper'

describe Rook do

  before(:each) do
    subject.position = 'A1'
  end

  it 'should respond to position' do
    expect(subject).to respond_to :position
  end

  it 'should respond to move with one arguement' do
    expect(subject).to respond_to(:move_to).with(1).argument
  end

  context 'when moving vertically' do

    it 'should be able to move forward one cell' do
      cell = double :cell, occupied?: false
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by){cell}
      subject.move_to 'A2'
      expect(subject.position).to eq 'A2'
    end

    it 'should be able to move forward more than one cell' do
      cell = double :cell, occupied?: false
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by) {cell}
      subject.move_to 'A8'
      expect(subject.position).to eq 'A8'
    end


    it 'should be able to move backward one space' do
      cell = double :cell, occupied?: false
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by) {cell}
      subject.position = 'A8'
      subject.move_to 'A7'
      expect(subject.position).to eq 'A7'
    end

    it 'should be able to move backward more than one cell' do
      cell = double :cell, occupied?: false
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by) {cell}
      subject.position = 'A8'
      subject.move_to 'A1'
      expect(subject.position).to eq 'A1'
    end

    it 'should not be able to continue moving vertically once taken a piece' do
      occupied_cell = double :occupied_cell, position: 'A2', occupied?: true
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position=>"A2"}){occupied_cell}
      expect{subject.move_to 'A4'}.to raise_error "Invalid Move"
    end

    it 'should not be able to continue moving vertically backward once taken a piece' do
      subject.position = 'A3'
      occupied_cell = double :occupied_cell, position: 'A2', occupied?: true
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position=>"A2"}){occupied_cell}
      expect{subject.move_to 'A1'}.to raise_error "Invalid Move"
    end
  end

  context 'when moving horizonatally' do
    it 'should be able to move horizontally one cell' do
      cell = double :cell, occupied?: false
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by) {cell}
      subject.move_to 'B1'
      expect(subject.position).to eq 'B1'
    end

    it 'should be able to move horizontally multiple cells' do
      empty_cell = double :empty_cell, occupied?: false
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by){empty_cell}
      subject.move_to 'H1'
      expect(subject.position).to eq 'H1'
    end

    it 'should not be able to continue moving right once taken a piece' do
      occupied_cell = double :occupied_cell, position: 'B1', occupied?: true
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position=>"B1"}){occupied_cell}
      expect{subject.move_to 'C1'}.to raise_error "Invalid Move"
    end

    it 'should not be able to continue moving left once take a piece' do
      subject.position = 'C1'
      occupied_cell = double :occupied_cell, position: 'B1', occupied?: true
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position=>"B1"}){occupied_cell}
      expect{subject.move_to 'A1'}.to raise_error "Invalid Move"
    end
  end

  context 'when trying to move diagonally' do
    it 'should not be able to move diagonally' do
      expect{subject.move_to 'B2'}.to raise_error "Invalid Move"
    end
  end
end

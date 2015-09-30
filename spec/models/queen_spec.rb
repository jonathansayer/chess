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
    expect(subject.position).to eq 'D3'
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
    cell = double :cell, occupied?: false
    allow(cell).to receive(:position)
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by) {cell}
    subject.move_to 'E5'
    expect(subject.position).to eq 'E5'
  end

  it 'should be able to move diagonally forward-left by one (from D4 to C5)' do
    cell = double :cell, occupied?: false
    allow(cell).to receive(:position)
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by) {cell}
    subject.move_to 'C5'
    expect(subject.position).to eq 'C5'
  end

  it 'should be able to move diagonally backward-right by one (from D4 to E3)' do
    cell = double :cell, occupied?: false
    allow(cell).to receive(:position)
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by) {cell}
    subject.move_to 'E3'
    expect(subject.position).to eq 'E3'
  end

  it 'should be able to move diagonally backward-left by one (from D4 to C3)' do
    cell = double :cell, occupied?: false
    allow(cell).to receive(:position)
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by) {cell}
    subject.move_to 'C3'
    expect(subject.position).to eq 'C3'
  end

  context 'when trying to make an invalid move' do

    it "should not be allowed to move to E6 from D4" do
      expect{subject.move_to 'E6'}.to raise_error 'Invalid Move'
    end

    it "should not be allowd to move to F5 from D4" do
      expect{subject.move_to 'F5'}.to raise_error "Invalid Move"
    end

    it "should not be allowed to move to F3 from D4" do
      expect{subject.move_to 'F3'}.to raise_error "Invalid Move"
    end

    it "should not be allowed to move to B5 from D4" do
      expect{subject.move_to 'B5'}.to raise_error "Invalid Move"
    end

    it 'should not be allowed to move to H6 from D4' do
      expect{subject.move_to 'H6'}.to raise_error "Invalid Move"
    end

  end

  it 'should not be allowed to move through a piece when moving forward' do
    occupied_cell = double :cell, position: 'D5', occupied?: true
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by).with({:position => 'D5'}) {occupied_cell}
    expect{subject.move_to 'D6'}.to raise_error 'Invalid Move'
  end

  it 'should not be allowed to move through a piece when moving backward' do
    occupied_cell = double :cell, position: 'D3', occupied?: true
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by).with({:position => 'D3'}) {occupied_cell}
    expect{subject.move_to 'D2'}.to raise_error 'Invalid Move'
  end

  it 'should not be allowed to move through a piece when moving right' do
    occupied_cell = double :cell, position: 'E4', occupied?: true
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by).with({:position => 'E4'}) {occupied_cell}
    expect{subject.move_to 'F4'}.to raise_error 'Invalid Move'
  end

  it 'should not be allowed to move through a piece when moving left' do
    occupied_cell = double :cell, position: 'C4', occupied?: true
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by).with({:position => 'C4'}) {occupied_cell}
    expect{subject.move_to 'B4'}.to raise_error 'Invalid Move'
  end

  it 'should not be allowed to move through a piece when moving diagonally forward-right' do
    to_cell = double :cell, position: 'D4', occupied?: true
    occupied_cell = double :cell, position: 'E5', occupied?: true
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by).with({:position => 'D4'}) {to_cell}
    allow(cell_class).to receive(:find_by).with({:position => 'E5'}) {occupied_cell}
    expect{subject.move_to 'F6'}.to raise_error 'Invalid Move'
  end

  it 'should not be allowed to move through a piece when moving diagonally forward-left' do
    to_cell = double :cell, position: 'D4', occupied?: true
    occupied_cell = double :cell, position: 'C5', occupied?: true
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by).with({:position => 'D4'}) {to_cell}
    allow(cell_class).to receive(:find_by).with({:position => 'C5'}) {occupied_cell}
    expect{subject.move_to 'B6'}.to raise_error 'Invalid Move'
  end

  it 'should not be allowed to move through a piece when moving diagonally backward-right' do
    to_cell = double :cell, position: 'D4', occupied?: true
    occupied_cell = double :cell, position: 'E3', occupied?: true
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by).with({:position => 'D4'}) {to_cell}
    allow(cell_class).to receive(:find_by).with({:position => 'E3'}) {occupied_cell}
    expect{subject.move_to 'F2'}.to raise_error 'Invalid Move'
  end

  it 'should not be allowed to move through a piece when moving diagonally backward-left' do
    to_cell = double :cell, position: 'D4', occupied?: true
    occupied_cell = double :cell, position: 'C3', occupied?: true
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by).with({:position => 'D4'}) {to_cell}
    allow(cell_class).to receive(:find_by).with({:position => 'C3'}) {occupied_cell}
    expect{subject.move_to 'B2'}.to raise_error 'Invalid Move'
  end

end

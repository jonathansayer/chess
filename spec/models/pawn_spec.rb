require 'rails_helper'

describe Pawn do

  before(:each) do
    subject.position = 'D2'
  end

  it 'should respond to move_forward with one argument' do
    expect(subject).to respond_to(:move_to).with(1).argument
  end

  it 'should know possible moves' do
    expect(subject).to respond_to(:possible_move?).with(1).argument
  end

  context "When move one square forward" do

    let(:to_cell){double :to_cell, position: 'D3'}

    before(:each) do
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position => 'D3'}) {to_cell}
      convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
      allow(convert_class).to receive(:to_numercal_coords).with('D2'){[4,2]}
      allow(convert_class).to receive(:to_numercal_coords).with('D3') {[4,3]}
      allow(convert_class).to receive(:to_alphabetical_coords).with([4,3]) {'D3'}
    end

    it 'should allow a pawn to move from D2 to D3' do
      allow(to_cell).to receive(:occupied?) {false}
      subject.move_to 'D3'
      expect(subject.position).to eq 'D3'
    end

    it 'should not be able to move forward if that square is occupied' do
      allow(to_cell).to receive(:occupied?) {true}
      expect{subject.move_to 'D3'}.to raise_error "Invalid Move"
    end

  end

  context "When moving two squares forward" do

    let(:to_cell){double :to_cell, position: 'D4', occupied?: false}
    let(:in_between_cell){double :in_between_cell, position: 'D3', occupied?: false}

    before(:each) do
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position => 'D4'}) {to_cell}
      allow(cell_class).to receive(:find_by).with({:position => 'D3'}){in_between_cell}
      allow(cell_class).to receive(:find_by).with({:position => 'D5'}){in_between_cell}
      convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
      allow(convert_class).to receive(:to_numercal_coords).with('D2'){[4,2]}
      allow(convert_class).to receive(:to_numercal_coords).with('D3'){[4,3]}
      allow(convert_class).to receive(:to_numercal_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numercal_coords).with('D5'){[4,5]}
      allow(convert_class).to receive(:to_alphabetical_coords).with([4,3]) {'D3'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([4,4]) {'D4'}
    end

    it 'should be able to move from D2 to D4' do
      subject.move_to 'D4'
      expect(subject.position).to eq 'D4'
    end

    it 'should not be able to move from D3 to D5' do
      subject.position = 'D3'
      allow(to_cell).to receive(:position) {'D5'}
      allow(in_between_cell).to receive(:position) { 'D4' }
      expect{subject.move_to 'D5'}.to raise_error "Invalid Move"
    end

    it 'should not be able to move two spaces if the cell directly infront is occupied' do
      allow(in_between_cell).to receive(:occupied?) { true }
      expect{subject.move_to 'D4'}.to raise_error "Invalid Move"
    end

    it 'should not be able to move two spaces if that space is occupied' do
      allow(to_cell).to receive(:occupied?) {true}
      expect{subject.move_to 'D4'}.to raise_error "Invalid Move"
    end
  end

  context "When moving diagonally" do

    let(:to_cell) { double :to_cell, position: 'E3', occupied?: true}

    before(:each) do
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position => 'E3'}) {to_cell}
      convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
      allow(convert_class).to receive(:to_numercal_coords).with('D2'){[4,2]}
      allow(convert_class).to receive(:to_numercal_coords).with('D3'){[4,3]}
      allow(convert_class).to receive(:to_numercal_coords).with('E3'){[5,3]}
      allow(convert_class).to receive(:to_numercal_coords).with('F4'){[6,4]}
      allow(convert_class).to receive(:to_alphabetical_coords).with([4,3]) {'D3'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([4,4]) {'D4'}
    end


    it 'should be able to move diagonally if that square is occupied' do
      in_between_cell = double :in_between_cell, position:'D3', occupied?: false
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position => 'E3'}) {to_cell}
      allow(cell_class).to receive(:find_by).with({:position => 'D3'}) {in_between_cell}
      subject.move_to 'E3'
      expect(subject.position).to eq 'E3'
    end

    it 'should not be able to move diagonally twice to an occupied square' do
      allow(to_cell).to receive(:position) {'F4'}
      expect{subject.move_to 'F4'}.to raise_error "Invalid Move"
    end

    it 'should not be able to move diagonally if cell is not occupied' do
      allow(to_cell).to receive(:occupied?) {false}
      expect{subject.move_to 'E3'}.to raise_error "Invalid Move"
    end

    it 'should be able to move diagonally if both the cell in front and the cell diagonally is occupied' do
      front_cell = double :front_cell, position: 'D3', occupied?: true
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position => 'E3'}) {to_cell}
      allow(cell_class).to receive(:find_by).with({:position => 'D3'}) {front_cell}
      expect{subject.move_to 'E3'}.not_to raise_error
    end
  end

end

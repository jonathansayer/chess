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

  context 'when moving horizontally and vertically by one square' do

    before(:each) do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
      allow(convert_class).to receive(:to_numerical_coords).with('C4'){[3,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('D3'){[4,3]}
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('D5'){[4,5]}
      allow(convert_class).to receive(:to_numerical_coords).with('E4'){[5,4]}
      allow(convert_class).to receive(:to_alphabetical_coords).with([3,4]) {'C4'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([4,3]) {'D3'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([4,4]) {'D4'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([4,5]) {'D5'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([5,4]) {'E4'}
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
  end

  context 'when moving diagonally by one' do

    let(:cell){double :cell, occupied?: false}

    before(:each) do
      allow(cell).to receive(:position)
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by) {cell}
      convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
      allow(convert_class).to receive(:to_numerical_coords).with('C3'){[3,3]}
      allow(convert_class).to receive(:to_numerical_coords).with('C5'){[3,5]}
      allow(convert_class).to receive(:to_numerical_coords).with('E3'){[5,3]}
      allow(convert_class).to receive(:to_numerical_coords).with('E5'){[5,5]}
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_alphabetical_coords).with([3,3]) {'C3'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([3,5]) {'C5'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([4,4]) {'D4'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([5,3]) {'E3'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([5,5]) {'E5'}
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

  context 'when trying to make an invalid move' do

    before(:each) do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
      allow(convert_class).to receive(:to_numerical_coords).with('B5'){[2,5]}
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('E6'){[5,6]}
      allow(convert_class).to receive(:to_numerical_coords).with('F3'){[6,3]}
      allow(convert_class).to receive(:to_numerical_coords).with('F5'){[6,5]}
      allow(convert_class).to receive(:to_numerical_coords).with('H6'){[8,6]}
    end

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

  context 'when trying to move through a piece horizontally or vertically' do

    before(:each) do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
      allow(convert_class).to receive(:to_numerical_coords).with('B4'){[2,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('D2'){[4,2]}
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('D6'){[4,6]}
      allow(convert_class).to receive(:to_numerical_coords).with('F4'){[6,4]}
      allow(convert_class).to receive(:to_alphabetical_coords).with([3,4]) {'C4'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([4,3]) {'D3'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([4,4]) {'D4'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([4,5]) {'D5'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([5,4]) {'E4'}
    end


    it 'should not be allowed to move through a piece when moving forward' do
      occupied_cell = double :cell, position: 'D5', occupied?: true
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position => occupied_cell.position}) {occupied_cell}
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

  end

  context 'when trying to move diagonally through a piece' do

    let(:from_cell){double :from_cell, position: 'D4', occupied?: true}

    before(:each) do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
      allow(convert_class).to receive(:to_numerical_coords).with('B2'){[2,2]}
      allow(convert_class).to receive(:to_numerical_coords).with('B6'){[2,6]}
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('F2'){[6,2]}
      allow(convert_class).to receive(:to_numerical_coords).with('F6'){[6,6]}
      allow(convert_class).to receive(:to_alphabetical_coords).with([3,3]) {'C3'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([3,5]) {'C5'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([4,4]) {'D4'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([5,3]) {'E3'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([5,5]) {'E5'}
    end

    it 'should not be allowed to move through a piece when moving diagonally forward-right' do
      occupied_cell = double :cell, position: 'E5', occupied?: true
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position => 'D4'}) {from_cell}
      allow(cell_class).to receive(:find_by).with({:position => 'E5'}) {occupied_cell}
      expect{subject.move_to 'F6'}.to raise_error 'Invalid Move'
    end

    it 'should not be allowed to move through a piece when moving diagonally forward-left' do
      occupied_cell = double :cell, position: 'C5', occupied?: true
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position => 'D4'}) {from_cell}
      allow(cell_class).to receive(:find_by).with({:position => 'C5'}) {occupied_cell}
      expect{subject.move_to 'B6'}.to raise_error 'Invalid Move'
    end

    it 'should not be allowed to move through a piece when moving diagonally backward-right' do
      occupied_cell = double :cell, position: 'E3', occupied?: true
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position => 'D4'}) {from_cell}
      allow(cell_class).to receive(:find_by).with({:position => 'E3'}) {occupied_cell}
      expect{subject.move_to 'F2'}.to raise_error 'Invalid Move'
    end

    it 'should not be allowed to move through a piece when moving diagonally backward-left' do
      occupied_cell = double :cell, position: 'C3', occupied?: true
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position => 'D4'}) {from_cell}
      allow(cell_class).to receive(:find_by).with({:position => 'C3'}) {occupied_cell}
    end
  end

end

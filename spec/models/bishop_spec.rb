require 'rails_helper'

describe Bishop do

  let(:from_cell){double :from_cell, position: 'D4', occupied?: true}
  let(:cell){double :cell, occupied?: false}

  before(:each) do
    subject.position = 'D4'
    allow(cell).to receive(:position)
    cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
    allow(cell_class).to receive(:find_by) {cell}
  end

  it 'should respond to position' do
    expect(subject).to respond_to :position
  end

  it 'should respond to move_to with one argument' do
    expect(subject).to respond_to(:move_to).with(1).argument
  end

  context "when moving diagonally by one" do

    before(:each) do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('C3'){[3,3]}
      allow(convert_class).to receive(:to_numerical_coords).with('C5'){[3,5]}
      allow(convert_class).to receive(:to_numerical_coords).with('E3'){[5,3]}
      allow(convert_class).to receive(:to_numerical_coords).with('E5'){[5,5]}
      allow(convert_class).to receive(:to_alphabetical_coords)
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

    it 'should be able to move diagonally backwards-left by 1(from D4 to C3)' do
      subject.move_to 'C3'
      expect(subject.position).to eq 'C3'
    end
  end

  context 'when making invalid moves' do

    before(:each) do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
      allow(convert_class).to receive(:to_numerical_coords).with('C4'){[3,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('D3'){[4,3]}
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('D5'){[4,5]}
      allow(convert_class).to receive(:to_numerical_coords).with('E4'){[5,4]}
    end

    it 'should not be able to move forward by one (from D4 to D5)' do
      expect{subject.move_to 'D5'}.to raise_error "Invalid Move"
    end

    it 'should not be able to move backward by one (from D4 to D3)' do
      expect{subject.move_to 'D3'}.to raise_error 'Invalid Move'
    end

    it 'should not be able to move to the right by one (from D4 to E4)' do
      expect{subject.move_to 'E4'}.to raise_error 'Invalid Move'
    end

    it 'should not be able to move to the left by one (from D4 to C4)' do
      expect{subject.move_to 'C4'}.to raise_error 'Invalid Move'
    end
  end

  context 'when moving diagonally with no limits' do

    before(:each) do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
      allow(convert_class).to receive(:to_numerical_coords).with('A1'){[1,1]}
      allow(convert_class).to receive(:to_numerical_coords).with('A7'){[1,7]}
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('G1'){[7,1]}
      allow(convert_class).to receive(:to_numerical_coords).with('H8'){[8,8]}
      allow(convert_class).to receive(:to_alphabetical_coords)

    end

    it 'should be able to move forward-right by any amounnt(from D4 to H8)' do
      subject.move_to 'H8'
      expect(subject.position).to eq 'H8'
    end

    it 'should be able to move forward-left by any amount (from D4 to A7)' do
      subject.move_to 'A7'
      expect(subject.position).to eq 'A7'
    end

    it 'should be able to move backward right by any amount (from D4 to G1)' do
      subject.move_to 'G1'
      expect(subject.position).to eq 'G1'
    end

    it 'should eb able to move backward left by any amount (from D4 to A1)' do
      subject.move_to 'A1'
      expect(subject.position).to eq 'A1'
    end
  end

  context 'when trying to move through other pieces' do

    before(:each) do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
      allow(convert_class).to receive(:to_numerical_coords).with('B2'){[2,2]}
      allow(convert_class).to receive(:to_numerical_coords).with('B6'){[2,6]}
      allow(convert_class).to receive(:to_numerical_coords).with('D4'){[4,4]}
      allow(convert_class).to receive(:to_numerical_coords).with('F2'){[6,2]}
      allow(convert_class).to receive(:to_numerical_coords).with('F6'){[6,6]}
      allow(convert_class).to receive(:to_alphabetical_coords).with([2,2]){'B2'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([2,6]){'B6'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([3,3]){'C3'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([3,5]){'C5'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([5,3]){'E3'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([6,2]){'F2'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([6,6]){'F6'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([4,4]){'D4'}
      allow(convert_class).to receive(:to_alphabetical_coords).with([5,5]){'E5'}
    end

    it 'should not be allowed to move any further forward-right diagonally after meeting another piece' do
      occupied_cell = double :cell, position: "E5", occupied?: true
      to_cell = double :cell, position: 'F6', occupied?: false
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position => occupied_cell.position}) {occupied_cell}
      allow(cell_class).to receive(:find_by).with({:position => from_cell.position}) {from_cell}
      allow(cell_class).to receive(:find_by).with({:position => to_cell.position}) {to_cell}
      expect{subject.move_to 'F6'}.to raise_error "Invalid Move"
    end

    it 'should not be allowed to move any further forward-left diagonally after meeting another piece' do
      occupied_cell = double :cell, position: "C5", occupied?: true
      to_cell = double :cell, position: 'B6', occupied?: false
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position => 'C5'}) {occupied_cell}
      allow(cell_class).to receive(:find_by).with({:position => 'D4'}) {from_cell}
      allow(cell_class).to receive(:find_by).with({:position => 'B6'}) {to_cell}
      expect{subject.move_to 'B6'}.to raise_error "Invalid Move"
    end

    it 'should not be allowed to move any further backward-right diagonally after meeting another piece' do
      occupied_cell = double :cell, position: "E3", occupied?: true
      to_cell = double :cell, position: 'F2', occupied?: false
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position => 'E3'}) {occupied_cell}
      allow(cell_class).to receive(:find_by).with({:position => 'D4'}) {from_cell}
      allow(cell_class).to receive(:find_by).with({:position => 'F2'}) {to_cell}
      expect{subject.move_to 'F2'}.to raise_error "Invalid Move"
    end

    it 'should not be allowed to move any further backward-left diagonally after meeting another piece' do
      occupied_cell = double :cell, position: "C3", occupied?: true
      to_cell = double :cell, position: 'B2', occupied?: false
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position => 'C3'}) {occupied_cell}
      allow(cell_class).to receive(:find_by).with({:position => 'D4'}) {from_cell}
      allow(cell_class).to receive(:find_by).with({:position => 'B2'}) {to_cell}
      expect{subject.move_to 'B2'}.to raise_error "Invalid Move"
    end
  end


end

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

    let(:empty_cell){double :empty_cell, occupied?: false}

    before(:each) do
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by){empty_cell}
      convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
      allow(convert_class).to receive(:to_numerical_coords).with('A1'){[1,1]}
      allow(convert_class).to receive(:to_numerical_coords).with('A2'){[1,2]}
      allow(convert_class).to receive(:to_numerical_coords).with('A7'){[1,7]}
      allow(convert_class).to receive(:to_numerical_coords).with('A8'){[1,8]}
      allow(convert_class).to receive(:to_alphabetical_coords)
    end

    it 'should be able to move forward one cell' do
      subject.move_to 'A2'
      expect(subject.position).to eq 'A2'
    end

    it 'should be able to move forward more than one cell' do
      subject.move_to 'A8'
      expect(subject.position).to eq 'A8'
    end


    it 'should be able to move backward one space' do
      subject.position = 'A8'
      subject.move_to 'A7'
      expect(subject.position).to eq 'A7'
    end

    it 'should be able to move backward more than one cell' do
      subject.position = 'A8'
      subject.move_to 'A1'
      expect(subject.position).to eq 'A1'
    end

    context 'when a piece is taken' do

      let(:occupied_cell){double :occupied_cell, position:'A2', occupied?: true}

      before(:each) do
        cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
        allow(cell_class).to receive(:find_by).with({:position=>"A2"}){occupied_cell}
        convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
        allow(convert_class).to receive(:to_numerical_coords).with('A1'){[1,1]}
        allow(convert_class).to receive(:to_numerical_coords).with('A3'){[1,3]}
        allow(convert_class).to receive(:to_numerical_coords).with('A4'){[1,4]}
        allow(convert_class).to receive(:to_alphabetical_coords).with([1,1]){'A1'}
        allow(convert_class).to receive(:to_alphabetical_coords).with([1,2]){'A2'}
        allow(convert_class).to receive(:to_alphabetical_coords).with([1,3]){'A3'}
      end

      it 'should not be able to continue moving vertically once taken a piece' do
        expect{subject.move_to 'A4'}.to raise_error "Invalid Move"
      end

      it 'should not be able to continue moving vertically backward once taken a piece' do
        subject.position = 'A3'
        expect{subject.move_to 'A1'}.to raise_error "Invalid Move"
      end
    end
  end

  context 'when moving horizonatally' do

    let(:empty_cell){double :empty_cell, occupied?:false}

    before(:each) do
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by){empty_cell}
      convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
      allow(convert_class).to receive(:to_numerical_coords).with('A1'){[1,1]}
      allow(convert_class).to receive(:to_numerical_coords).with('B1'){[2,1]}
      allow(convert_class).to receive(:to_numerical_coords).with('H1'){[8,1]}
      allow(convert_class).to receive(:to_alphabetical_coords)
    end

    it 'should be able to move horizontally one cell' do
      subject.move_to 'B1'
      expect(subject.position).to eq 'B1'
    end

    it 'should be able to move horizontally multiple cells' do
      subject.move_to 'H1'
      expect(subject.position).to eq 'H1'
    end

    context'when a piece is taken' do

      let(:occupied_cell){double :occupied_cell, position:'B1', occupied?:true}

      before(:each) do
        cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
        allow(cell_class).to receive(:find_by).with({:position=>"B1"}){occupied_cell}
        convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
        allow(convert_class).to receive(:to_numerical_coords).with('A1'){[1,1]}
        allow(convert_class).to receive(:to_numerical_coords).with('C1'){[3,1]}
        allow(convert_class).to receive(:to_alphabetical_coords).with([1,1]){'A1'}
        allow(convert_class).to receive(:to_alphabetical_coords).with([2,1]){'B1'}
        allow(convert_class).to receive(:to_alphabetical_coords).with([3,1]){'C1'}
      end

      it 'should not be able to continue moving right once taken a piece' do
        expect{subject.move_to 'C1'}.to raise_error "Invalid Move"
      end

      it 'should not be able to continue moving left once take a piece' do
        subject.position = 'C1'
        expect{subject.move_to 'A1'}.to raise_error "Invalid Move"
      end
    end
  end

  context 'when trying to move diagonally' do
    it 'should not be able to move diagonally' do
      convert_class = class_double('ConvertCoordinates').as_stubbed_const(:transfer_nested_constants => true)
      allow(convert_class).to receive(:to_numerical_coords).with('A1'){[1,1]}
      allow(convert_class).to receive(:to_numerical_coords).with('B2'){[2,2]}
      expect{subject.move_to 'B2'}.to raise_error "Invalid Move"
    end
  end
end

require 'rails_helper'

describe Board do

  let(:pawn){double :pawn, position: 'D4'}
  let(:to_cell){double :to_cell, occupied?: false}
  let(:from_cell){double :from_cell}

  context 'not occupied cell' do

    before(:each) do
      cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
      allow(cell_class).to receive(:find_by).with({:position=>"D5"}){to_cell}
      allow(cell_class).to receive(:find_by).with({:position=>"D4"}){from_cell}
    end


    it 'should respond to move_piece with two arguments' do
      expect(subject).to respond_to(:move_piece).with(2).argument
    end

    it 'should call the move_to method for the piece' do
      allow(to_cell).to receive(:change_occupied_mode)
      allow(from_cell).to receive(:change_occupied_mode)
      expect(pawn).to receive(:move_to)
      subject.move_piece pawn, 'D5'
    end

    it 'should change the occupied state of the Cell that the piece moves to' do
      allow(pawn).to receive(:move_to)
      allow(from_cell).to receive(:change_occupied_mode)
      expect(to_cell).to receive(:change_occupied_mode)
      subject.move_piece pawn, 'D5'
    end

    it 'should change the occupied state of the Cell that the piece move away from' do
      allow(pawn).to receive(:move_to)
      allow(to_cell).to receive(:change_occupied_mode)
      expect(from_cell).to receive(:change_occupied_mode)
      subject.move_piece pawn, 'D5'
    end
  end

    context 'occupied cell' do

      let(:to_cell){double :to_cell, occupied?: true, position: 'E5'}
      let(:pawn2){double :pawn2, position:'E5'}

      before(:each) do
        allow(pawn).to receive(:move_to)
        allow(from_cell).to receive(:change_occupied_mode)
        cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
        allow(cell_class).to receive(:find_by).with({:position=>"E5"}){to_cell}
        allow(cell_class).to receive(:find_by).with({:position=>"D4"}){from_cell}
        pawn_class = class_double('Pawn').as_stubbed_const(:transfer_nested_constants => true)
        allow(pawn_class).to receive(:exists?).with({:position=>"E5"}){true}
        allow(pawn_class).to receive(:where).with({:position=>"E5"}){[pawn2]}

      end


    it 'should be able to move to a cell which is already occupied and cell shoudl still be occupied' do
      allow(pawn2).to receive(:update_column).with("position", "Off Board")
      expect(to_cell).not_to receive(:change_occupied_mode)
      subject.move_piece pawn, 'E5'
    end

    it 'should be able to move a piece off that board when another piece moves to that cell' do
      expect(pawn2).to receive(:update_column).with("position", "Off Board")
      subject.move_piece pawn, 'E5'
    end
  end
end

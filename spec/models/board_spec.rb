require 'rails_helper'

describe Board do

  let(:pawn){double :pawn, position: 'D4', white?: true}
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
      let(:pawn2){double :pawn2, position:'E5', white?: false}

      before(:each) do
        allow(pawn).to receive(:move_to)
        allow(from_cell).to receive(:change_occupied_mode)
        cell_class = class_double('Cell').as_stubbed_const(:transfer_nested_constants => true)
        allow(cell_class).to receive(:find_by).with({:position=>"E5"}){to_cell}
        allow(cell_class).to receive(:find_by).with({:position=>"D4"}){from_cell}
        pawn_class = class_double('Pawn').as_stubbed_const(:transfer_nested_constants => true)
        allow(pawn_class).to receive(:exists?).with({:position=>"E5", white?: false}){true}
        allow(pawn_class).to receive(:where).with({:position=>"E5", white?: false}){[pawn2]}
      end

    it 'should be able to move to a cell which is already occupied and cell should still be occupied' do
      allow(pawn2).to receive(:destroy)
      expect(to_cell).not_to receive(:change_occupied_mode)
      subject.move_piece pawn, 'E5'
    end

    it 'should be able to move a piece of the opposite colour off that board when another piece moves to that cell' do
      expect(pawn2).to receive(:destroy)
      subject.move_piece pawn, 'E5'
    end

    it 'should not be able to move a piece of the same colour off that board when another piece moves to that cell' do
      pawn2 = double :pawn2, position: 'E5', white?: true
      pawn_class = class_double('Pawn').as_stubbed_const(:transfer_nested_constants => true)
      allow(pawn_class).to receive(:exists?).with({:position=>"E5", white?: false}){false}
      expect{subject.move_piece pawn, 'E5'}.to raise_error 'Invalid Move'
    end
  end

  context 'when a king is in check' do

    let(:white_king){double :white_king, position:'D4', white?: true}
    let(:black_king){double :black_king, position:'D6', white?: false}
    before(:each) do
      pawn = double :pawn
      allow(pawn).to receive(:possible_move?) {false}
      pawn_class = class_double('Pawn').as_stubbed_const
      allow(pawn_class).to receive(:where){[pawn]}
      knight = double :knight
      allow(knight).to receive(:possible_move?) {false}
      knight_class = class_double('Knight').as_stubbed_const
      allow(knight_class).to receive(:where){[knight]}
      bishop = double :bishop
      allow(bishop).to receive(:possible_move?) {false}
      bishop_class = class_double('Bishop').as_stubbed_const
      allow(bishop_class).to receive(:where){[bishop]}
      queen = double :queen
      allow(queen).to receive(:possible_move?) {false}
      queen_class = class_double('Queen').as_stubbed_const
      allow(queen_class).to receive(:where){[queen]}
      king = double :king
      allow(black_king).to receive(:possible_move?) {false}
      allow(white_king).to receive(:possible_move?) {false}
      king_class = class_double('King').as_stubbed_const
      allow(king_class).to receive(:where).with({:white? => true}){[white_king]}
      allow(king_class).to receive(:where).with({:white? => false}){[black_king]}
    end


    it 'should know when a white king is in cheque from the opposite colour' do
      rook = double :rook, white?: false
      allow(rook).to receive(:possible_move?) {true}
      rook_class = class_double('Rook').as_stubbed_const(:transfer_nested_constants => true)
      allow(rook_class).to receive(:where).with({:white? => false}){[rook]}
      allow(rook_class).to receive(:where).with({:white? => true})
      expect(subject.in_check? 'white').to eq true
    end

    it 'should know when a white king is not in cheque from the opposite colour' do
      black_rook = double :black_rook, white?: false
      allow(black_rook).to receive(:possible_move?) {false}
      white_rook = double :white_rook, white?: true
      allow(white_rook).to receive(:possible_move?) {false}
      rook_class = class_double('Rook').as_stubbed_const(:transfer_nested_constants => true)
      allow(rook_class).to receive(:where).with({:white? => false}){[black_rook]}
      expect(subject.in_check? 'white').to eq false
    end

    it 'should know when a black king is in check from a white piece' do
      white_rook = double :rook, white?: true
      allow(white_rook).to receive(:possible_move?) {true}
      black_rook = double :rook, white?: false
      allow(black_rook).to receive(:possible_move?) {false}
      rook_class = class_double('Rook').as_stubbed_const
      allow(rook_class).to receive(:where).with({:white? => true}){[white_rook]}
      expect(subject.in_check? 'black').to eq true
    end
  end

  context 'when check mate occurs' do

    def king_moves colour
      is_white = false
      is_white = true if colour == "white"
      king = colour + "_king"
      @king = double king.to_sym, position:'B1', white?:is_white
      allow(@king).to receive(:all_possible_moves){['A1','B1','C1','C2','C3','B3','A3','A2']}
      allow(@king).to receive(:position=).with('A1'){'A1'}
      allow(@king).to receive(:position=).with('B1'){'B1'}
      allow(@king).to receive(:position=).with('C1'){'C1'}
      allow(@king).to receive(:position=).with('C2'){'C2'}
      allow(@king).to receive(:position=).with('C3'){'C3'}
      allow(@king).to receive(:position=).with('B3'){'B3'}
      allow(@king).to receive(:position=).with('A3'){'A3'}
      allow(@king).to receive(:position=).with('A2'){'A2'}
    end

    def place_pieces_for_checkmate colour
      is_white = false
      is_white = true if colour == "white"
      queen = colour + "_queen"
      rook1 = colour + "_rook1"
      rook2 = colour + "_rook2"
      @queen = double queen.to_sym, position:'B4', white?:is_white
      @rook1 = double rook1.to_sym, position:'D1', white?:is_white
      @rook2 = double rook2.to_sym, position:'F2', white?:is_white
    end

    def class_stubbing colour
      is_white = false
      is_white = true if colour == "white"
      king_class = class_double('King').as_stubbed_const
      allow(king_class).to receive(:where).with({:white? => !is_white}){[@king]}
      allow(king_class).to receive(:where).with({:white? => is_white}){[]}
      rook_class = class_double('Rook').as_stubbed_const
      allow(rook_class).to receive(:where).with({:white? => is_white}){[@rook1, @rook2]}
      queen_class = class_double('Queen').as_stubbed_const
      allow(queen_class).to receive(:where).with({:white? => is_white}){[@queen]}
    end

    def allow_pieces_to_receive_possible_move
      allow(@rook1).to receive(:possible_move?){true}
      allow(@rook2).to receive(:possible_move?){true}
      allow(@queen).to receive(:possible_move?){true}
    end



    it 'should know when a white player is in check mate' do
      king_moves 'white'
      place_pieces_for_checkmate 'black'
      class_stubbing 'black'
      allow_pieces_to_receive_possible_move
      expect(subject.check_mate? 'white').to eq true
    end

    it 'should know when a black player is in check mate' do
      king_moves 'black'
      place_pieces_for_checkmate 'white'
      king_class = class_double('King').as_stubbed_const
      class_stubbing 'white'
      allow_pieces_to_receive_possible_move
      expect(subject.check_mate? 'black').to eq true
    end
  end
end

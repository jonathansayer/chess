require 'rails_helper'

feature 'Moving a piece' do
  scenario 'I should be able to move a pawn on the board from A2 to A3' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')
    Board.create
    Cell.create(position: 'A2', occupied?: false)
    Cell.create(position: 'A3', occupied?: false)
    Cell.create(position: 'A4', occupied?: false)
    pawn = Pawn.create(position:'A2', white?: true)
    player.move pawn, 'A3'
    expect(pawn.position).to eq 'A3'
  end

  scenario 'I should be able to move a pawn on the board from A2 to A4' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')
    Board.create
    Cell.create(position: 'A2', occupied?: true)
    Cell.create(position: 'A3', occupied?: false)
    Cell.create(position: 'A4', occupied?: false)
    pawn = Pawn.create(position:'A2', white?: true)
    player.move pawn, 'A3'
    expect(pawn.position).to eq 'A3'
  end

  scenario 'I should not be able to move a pawn if there is another piece infront' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')
    Board.create
    Cell.create(position: 'A2', occupied?: true)
    Cell.create(position: 'A3', occupied?: true)
    Cell.create(position: 'B3', occupied?: false)
    Cell.create(position: 'A4', occupied?: false)
    pawn = Pawn.create(position:'A2', white?: true)
    expect{player.move pawn, 'A3'}.to raise_error "Invalid Move"
  end

  scenario 'I should be able to move a pawn if there is another piece infront but another diagonal' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')
    Board.create
    Cell.create(position: 'A2', occupied?: true)
    Cell.create(position: 'A3', occupied?: true)
    Cell.create(position: 'B3', occupied?: true)
    Cell.create(position: 'A4', occupied?: false)
    Rook.create(position: 'B3', white?: false)
    pawn = Pawn.create(position:'A2', white?: true)
    player.move pawn, 'B3'
    expect(pawn.position).to eq 'B3'
  end

  scenario 'I should be able to take a piece off the board' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')
    Board.create
    Cell.create(position: 'A2', occupied?: false)
    Cell.create(position: 'A3', occupied?: false)
    Cell.create(position: 'B3', occupied?: true)
    Cell.create(position: 'A4', occupied?: false)
    pawn = Pawn.create(position:'A2', white?: true)
    Pawn.create(position:'B3', white?: false)
    player.move pawn, 'B3'
    expect(Pawn.where(white?:false, position:'A3')).to_not exist
  end

  scenario 'I should not be able to take a piece off the board if it is the same colour' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')
    Board.create
    Cell.create(position: 'A2', occupied?: false)
    Cell.create(position: 'A3', occupied?: false)
    Cell.create(position: 'B3', occupied?: true)
    Cell.create(position: 'A4', occupied?: false)
    pawn = Pawn.create(position:'A2', white?: true)
    Pawn.create(position:'B3', white?: false)
    player.move pawn, 'B3'
    expect(Pawn.where(white?:false, position:'A3')).to_not exist
  end
end
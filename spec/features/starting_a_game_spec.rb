require 'rails_helper'

feature 'Moving a piece' do

  scenario 'I should be able to move a pawn on the board from A2 to A3' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')
    pawn = Pawn.create(position:'A2', white?: true)
    cell1 = Cell.create(position: 'A2', occupied?: true)
    cell2 = Cell.create(position: 'A3', occupied?: false)
    Board.create
    player.move pawn, 'A3'
    expect(pawn.position).to eq 'A3'
  end

  scenario 'I should be able to move a pawn on the board from A2 to A4' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')
    pawn = Pawn.create(position:'A2', white?: true)
    Cell.create(position:'A4', occupied?:false)
    Cell.create(position:'A3', occupied?:false)
    Cell.create(position:'A2', occupied?:true)
    Board.create
    player.move pawn, 'A3'
    expect(pawn.position).to eq 'A3'
  end

  scenario 'I should not be able to move a pawn if there is another piece infront' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')
    pawn = Pawn.create(position:'A2', white?: true)
    pawn2 = Pawn.create(position:'A3', white?: false)
    Cell.create(position:'A3', occupied?:true)
    Cell.create(position:'A2', occupied?:true)
    Board.create
    expect{player.move pawn, 'A3'}.to raise_error "Invalid Move"
  end

  scenario 'I should be able to move a pawn if there is another piece infront but another diagonal' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')
    Cell.create(position: 'B3', occupied?: true)
    Cell.create(position: 'A3', occupied?: true)
    Cell.create(position: 'A2', occupied?: true)
    Pawn.create(position:'B3', white?: false)
    Pawn.create(position:'A3', white?: false)
    pawn = Pawn.create(position:'A2', white?: true)
    Board.create
    player.move pawn, 'B3'
    expect(pawn.position).to eq 'B3'
  end

  scenario 'I should be able to take a piece off the board' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')
    pawn = Pawn.create(position:'A2', white?: true)
    Pawn.create(position:'B3', white?: false)
    Cell.create(position: 'B3', occupied?: true)
    Cell.create(position: 'A2', occupied?: true)
    Cell.create(position:'A3', occupied?:true)
    Board.create
    player.move pawn, 'B3'
    expect(Pawn.where(white?:false, position:'B3')).to_not exist
  end

  scenario 'I should not be able to take a piece off the board if it is the same colour' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')
    pawn = Pawn.create(position:'A2', white?: true)
    Pawn.create(position:'B3', white?: true)
    Cell.create(position: 'B3', occupied?: true)
    Cell.create(position: 'A2', occupied?: true)
    Cell.create(position: 'A3', occupied?: false)
    Board.create
    expect{player.move pawn, 'B3'}.to raise_error "Invalid Move"
  end
end

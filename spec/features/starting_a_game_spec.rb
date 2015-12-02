require 'rails_helper'

feature 'Moving a piece' do
  scenario 'I should be able to move a pawn on the board from A2 to A3' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')

    pawn = Pawn.find_by(position:'A2', white?: true)
    player.move pawn, 'A3'
    expect(pawn.position).to eq 'A3'
  end

  scenario 'I should be able to move a pawn on the board from A2 to A4' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')
    
    pawn = Pawn.find_by(position:'A2', white?: true)
    player.move pawn, 'A3'
    expect(pawn.position).to eq 'A3'
  end

  scenario 'I should not be able to move a pawn if there is another piece infront' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')
    Board.create
    pawn = Pawn.find_by(position:'A2', white?: true)
    pawn2 = Pawn.create(position:'A3', white?: true)
    cell = Cell.find_by(position:'A3')
    cell.change_occupied_mode
    expect{player.move pawn, 'A3'}.to raise_error "Invalid Move"
  end

  scenario 'I should be able to move a pawn if there is another piece infront but another diagonal' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')
    Board.create
    cell1 = Cell.find_by(position: 'B3')
    cell1.change_occupied_mode
    cell2 = Cell.find_by(position: 'A3')
    cell2.change_occupied_mode
    pawn = Pawn.find_by(position:'A2', white?: true)
    Pawn.create(position:'B3', white?: false)
    player.move pawn, 'B3'
    expect(pawn.position).to eq 'B3'
  end

  scenario 'I should be able to take a piece off the board' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')
    Board.create
    pawn = Pawn.find_by(position:'A2', white?: true)
    Pawn.create(position:'B3', white?: false)
    cell = Cell.find_by(position: 'B3')
    cell.change_occupied_mode
    player.move pawn, 'B3'
    expect(Pawn.where(white?:false, position:'B3')).to_not exist
  end

  scenario 'I should not be able to take a piece off the board if it is the same colour' do
    player = Player.create(name:'Jon',colour:'white', status: 'playing')
    Board.create
    pawn = Pawn.find_by(position:'A2', white?: true)
    Pawn.create(position:'B3', white?: true)
    cell = Cell.find_by(position: 'B3')
    cell.change_occupied_mode
    expect{player.move pawn, 'B3'}.to raise_error "Invalid Move"
  end
end

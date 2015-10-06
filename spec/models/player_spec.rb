require 'rails_helper'

describe Player do


    let(:subject) {Player.new('white')}

  it 'must have an associated colour' do
    expect(subject.colour).to eq 'white'
  end

  it 'must be able to move a piece' do
    board = double :board
    pawn = double :pawn, position: 'A2', white?: true
    expect(board).to receive(:move_piece).with(pawn,'A3')
    subject.move pawn, 'A3', board
  end

  it 'must have a status' do
    expect(subject).to respond_to :status
  end

  it 'must have a status which can change' do
    expect(subject).to respond_to(:status=).with(1).argument
  end

  it 'must be initialized with a "playing" status' do
    expect(subject.status).to eq "playing"
  end

  it 'must respond to win' do
    expect(subject).to respond_to(:win)
  end

  it 'must be able to win' do
    subject.win
    expect(subject.status).to eq "Winner"
  end

  it 'must respond to lose' do
    expect(subject).to respond_to(:lose)
  end

  it 'must be able to lose' do
    subject.lose
    expect(subject.status).to eq 'You Lost!'
  end
end

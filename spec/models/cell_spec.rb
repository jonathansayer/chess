require 'rails_helper'

describe Cell do

  it 'should respond position' do
    expect(subject).to respond_to :position
  end

  it 'should respond to occupied?' do
    expect(subject).to respond_to :occupied?
  end

  it 'should respond to change_occupied_mode' do
    expect(subject).to respond_to :change_occupied_mode
  end

  it 'should be able to change occupied mode' do
    subject = Cell.create(occupied?: false)
    subject.change_occupied_mode
    expect(subject.occupied?).to eq true
  end

  it 'should be able to change occupied mode from true to false' do
    subject = Cell.create(occupied?: true )
    subject.change_occupied_mode
    expect(subject.occupied?).to eq false
  end
end

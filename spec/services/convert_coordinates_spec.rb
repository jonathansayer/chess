require 'rails_helper'

describe ConvertCoordinates do

  let(:subject){ConvertCoordinates}

  it 'should respond to convert with one argument' do
    expect(subject).to respond_to(:to_numercal_coords ).with(1).argument
  end

  it 'should take a traditonal chess position, A1, and convert to x and y coorindates [1,1]' do
    expect(subject.to_numercal_coords 'A1').to eq [1,1]
  end

  it 'should take a traditional chess position, B2, and convert to x and y cooridnates [2,2]' do
    expect(subject.to_numercal_coords 'B2').to eq [2,2]
  end

  it 'should take a traditional chess position, E7, and convert to x and y cooridnates [5,7]' do
    expect(subject.to_numercal_coords 'E7').to eq [5,7]
  end

  it 'should repsond to convert_to_alphabetical_coords with one arguement' do
    expect(subject).to respond_to(:to_alphabetical_coords).with(1).argument
  end

  it 'should be able to convert x and y,[1,1] coordinates to a chess postion A1' do
    expect(subject.to_alphabetical_coords [1,1]).to eq 'A1'
  end

  it 'should be able to convert x and y,[7,2] coordinates to a chess postion G1' do
    expect(subject.to_alphabetical_coords [7,2]).to eq 'G2'
  end

  it 'should take a range of coordintes and return a range of position' do
    expect(subject.to_alphabetical_coords [1,1],[2,2]).to eq ['A1','B2']
  end

  it 'should be able to take a range of positions and convert them to an array of coords' do
    expect(subject.to_numercal_coords 'A1', 'B2').to eq [[1,1],[2,2]]
  end

end

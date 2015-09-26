require 'rails_helper'

describe Cell do

  it 'should respond position' do
    expect(subject).to respond_to :position
  end

  it 'should respond to occupied' do
    expect(subject).to respond_to :occupied?
  end
end

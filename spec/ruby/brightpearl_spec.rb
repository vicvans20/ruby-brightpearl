# frozen_string_literal: true

RSpec.describe Brightpearl do
  it "has a version number" do
    expect(Brightpearl::VERSION).not_to be nil
  end

  xit "does something useful" do
    expect(false).to eq(true)
  end

  context '.config' do 
    it 'is an instance of Config' do 
      expect(Brightpearl.config).to be_an_instance_of(Brightpearl::Config)
    end
  end
end

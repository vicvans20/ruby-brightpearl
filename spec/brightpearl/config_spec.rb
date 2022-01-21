require 'spec_helper'

RSpec.describe Brightpearl::Config do
  context '#api_url_base' do
    it 'is nil by default' do
      expect(described_class.new.api_url_base).to be_nil
    end

    it 'is writable' do
      expect(described_class.new).to respond_to(:api_url_base=)
    end

    it 'is readable' do
      expect(described_class.new).to respond_to(:api_url_base)
    end
  end

  context '#api_key' do
    it 'is nil by default' do
      expect(described_class.new.app_ref).to be_nil
    end

    it 'is writable' do
      expect(described_class.new).to respond_to(:app_ref=)
    end

    it 'is readable' do
      expect(described_class.new).to respond_to(:app_ref)
    end
  end
end
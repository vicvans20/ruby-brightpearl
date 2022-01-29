require 'spec_helper'

RSpec.describe Brightpearl::Config do
  context '#api_domain' do
    it 'is nil by default' do
      expect(described_class.new.api_domain).to be_nil
    end

    it 'is writable' do
      expect(described_class.new).to respond_to(:api_domain=)
    end

    it 'is readable' do
      expect(described_class.new).to respond_to(:api_domain)
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
# frozen_string_literal: true

RSpec.describe Brightpearl::ContactCustomFieldMetadata do
  describe "GET" do
    it "validates the contact type" do
      expect {
        described_class.get("sale")
      }.to raise_error(ArgumentError, /Invalid contact custom field metadata type/)
    end
  end
end

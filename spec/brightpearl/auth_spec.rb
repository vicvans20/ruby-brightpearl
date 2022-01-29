require 'spec_helper'

RSpec.describe Brightpearl::Auth do
  it "generate url as expected" do
    # TODO test against the URL generated
    expect(Brightpearl::Auth.oauth_url("random-passcode")).to be_truthy
  end
end
require 'spec_helper'

RSpec.describe Brightpearl::Client do
  xit 'Common errors with wrong order IDs' do
    # TODO
  end
  xit "Throttling error" do
  end

  xit "raise error when no config detected" do
  end

  it "raise error when token has expired" do
    VCR.use_cassette("client_error_expired") do
      Brightpearl.config.token = "ueHd8764HcvzKsSIjo28RZna6+91EDDuYnF47kP1DCE=" # Invalid/Expired token
      expect { response = Brightpearl::Order.get(1) }.to raise_error(Brightpearl::InvalidToken)
      expect { response = Brightpearl::Product.get(1) }.to raise_error(Brightpearl::InvalidToken)
    end
  end

  it "raise error when token is invalid" do
    VCR.use_cassette("client_error_invalid") do
      Brightpearl.config.token = "INVALID_STUFF" # Invalid/Expired token
      expect { response = Brightpearl::Order.get(1) }.to raise_error(Brightpearl::InvalidToken)
      expect { response = Brightpearl::Product.get(1) }.to raise_error(Brightpearl::InvalidToken)
    end
  end

  it "Use a temporal token successfully" do
    VCR.use_cassette("order_get_one") do
      Brightpearl::Client.temp(token: "F9yhblu8n5jweUTrL+QgGe8DQwx/f8wN+78cdNAQ0A=") do 
        response = Brightpearl::Order.get(1)
        expect(response).to include(payload: be_truthy)
      end
    end
  end

end
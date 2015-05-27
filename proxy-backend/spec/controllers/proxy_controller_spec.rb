require 'rails_helper'

RSpec.describe ProxyController, type: :controller do
  describe "POST #add_proxy" do
    before do
    end

    it "add us http proxy succ" do
      post :add_proxy, proxy_url: "http://75.126.26.180:80"
      expect(ProxyDomain.first.country).to eq "US"
    end
  end

end

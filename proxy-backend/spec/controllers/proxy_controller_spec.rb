require 'rails_helper'

RSpec.describe ProxyController, type: :controller do
  describe "POST #add_proxy" do
    before do
    end

    it "add us http proxy succ" do
      post :add_proxy, proxy_url: "http://75.126.26.180:80"
      expect(ProxyDomain.first.country).to eq "US"
    end

    it "add https proxy fail" do
      post :add_proxy, proxy_url: "https://75.126.26.180:80"
      expect(ProxyDomain.all.count).to eq 0
    end

    it "add proxy not from us fail" do
      post :add_proxy, proxy_url: "https://41.188.49.159:8080"
      expect(ProxyDomain.all.count).to eq 0
    end

  end

  describe "POST #report_proxy_stats" do
    it "report domain proxy use num" do
      data = {
        "use_num" => {
        "www.wego.com" => {"succ"=>0, "total"=>13}
        },
        "proxy" => "http://75.144.226.89:8080/"
      }

      post :report_proxy_stats,  ActionController::Parameters.new(data)
      puts response
    end

  end

end

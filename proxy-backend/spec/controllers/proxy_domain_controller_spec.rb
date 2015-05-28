require 'rails_helper'

RSpec.describe ProxyDomainController, type: :controller do

  describe "GET #get_proxy" do
    it "get proxy correct" do
      high_proxy = create(:high_proxy)
      middle_proxy = create(:middle_proxy)
      low_proxy = create(:low_proxy)
      get 'get_proxy'
      expect(JSON.parse(response.body)['proxy']).to eq high_proxy.proxy
      get 'get_proxy'
      expect(JSON.parse(response.body)['proxy']).to eq middle_proxy.proxy
    end

    it "get proxy correct with proxy in use" do
      high_proxy_in_use = create(:high_proxy, :in_use)
      middle_proxy = create(:middle_proxy)
      low_proxy = create(:low_proxy)
      get 'get_proxy'
      expect(JSON.parse(response.body)['proxy']).to eq middle_proxy.proxy
    end

    it "get proxy correct with proxy in use or banned" do
      high_proxy_in_use = create(:high_proxy, :in_use)
      middle_proxy_banned  = create(:middle_proxy, :banned)
      low_proxy = create(:low_proxy)
      get 'get_proxy'
      expect(JSON.parse(response.body)['proxy']).to eq low_proxy.proxy
    end

    it "get default proxy with proxy all in use or banned" do
      high_proxy_in_use = create(:high_proxy, :in_use)
      middle_proxy_banned  = create(:middle_proxy, :banned)
      low_proxy_banned  = create(:low_proxy, :banned)
      get 'get_proxy'
      expect(JSON.parse(response.body)['proxy']).to eq ENV['DEFAULT_PROXY']
    end
  end

  describe "POST #report_proxy_stats" do
    it "report domain proxy use num" do
      proxy = create(:proxy_domain, proxy: "http://75.144.226.89:8080/", succ: 10, total: 15)
      data = {
        "use_num" => {
        "www.wego.com" => {"succ"=>0, "total"=>25}
        },
        "proxy" => "http://75.144.226.89:8080/"
      }
      post :report_proxy_stats,  ActionController::Parameters.new(data)
      expect(ProxyDomain.first.succ).to eq 10
      expect(ProxyDomain.first.total).to eq 40
      expect(ProxyDomain.first.succ_ratio).to eq 0.25
    end

  end

end

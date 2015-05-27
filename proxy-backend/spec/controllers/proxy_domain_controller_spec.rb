require 'rails_helper'

RSpec.describe ProxyDomainController, type: :controller do

  describe "GET #get_proxy" do
    it "get proxy correct" do
      high_proxy = create(:high_proxy)
      middle_proxy = create(:middle_proxy)
      low_proxy = create(:low_proxy)
      get 'get_proxy'
      puts ProxyDomain.all
      puts JSON.parse(response.body)
      puts JSON.parse(response.body)['proxy']
      puts high_proxy.proxy
      expect(JSON.parse(response.body)['proxy']).to eq high_proxy.proxy
    end

    it "get proxy correct with proxy in use" do
      #high_proxy_in_use = create(:high_proxy_in_use)
      high_proxy_in_use = create(:high_proxy, :in_use)
      middle_proxy = create(:middle_proxy)
      low_proxy = create(:low_proxy)

      get 'get_proxy'

      expect(JSON.parse(response.body)['proxy']).to eq middle_proxy.proxy
    end

    it "get proxy correct with proxy in use or banned" do
      #high_proxy_in_use = create(:high_proxy_in_use)
      high_proxy_in_use = create(:high_proxy, :in_use)
      middle_proxy_banned  = create(:middle_proxy, :banned)
      low_proxy = create(:low_proxy)

      get 'get_proxy'

      expect(JSON.parse(response.body)['proxy']).to eq low_proxy.proxy
    end

    it "get default proxy with proxy all in use or banned" do
      #high_proxy_in_use = create(:high_proxy_in_use)
      high_proxy_in_use = create(:high_proxy, :in_use)
      middle_proxy_banned  = create(:middle_proxy, :banned)
      low_proxy_banned  = create(:low_proxy, :banned)

      get 'get_proxy'

      expect(JSON.parse(response.body)['proxy']).to eq low_proxy_banned.proxy
    end



  end


end

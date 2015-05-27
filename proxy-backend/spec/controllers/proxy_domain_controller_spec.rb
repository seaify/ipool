require 'rails_helper'

RSpec.describe ProxyDomainController, type: :controller do

  describe "GET #get_proxy" do
    it "get proxy correct" do
      high_proxy = create(:high_proxy)
      middle_proxy = create(:middle_proxy)
      low_proxy = create(:low_proxy)
      get 'get_proxy'
      puts response
      #check_json(response.body, :success, true)

      puts ProxyDomain.all
      puts JSON.parse(response.body)
      puts JSON.parse(response.body)['proxy']
      puts high_proxy.proxy
      expect(JSON.parse(response.body)['proxy']).to eq high_proxy.proxy
    end

  end


end

class ProxyDomainController < ApplicationController
  def proxy_domains
  	@proxy_domains = ProxyDomain.all 
  	respond_to do |format|
  		format.json { render :json => @proxy_domains }
  	end
  end
end

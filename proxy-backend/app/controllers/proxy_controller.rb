class ProxyController < ApplicationController
	def proxys
  		@proxys = Proxy.all 
    		return render :json => {:data => @proxys}, :callback => params[:callback]
  	end

	def proxy_domains
  		@proxys = ProxyDomain.all 
    		return render :json => {:data => @proxys, :callback => params[:callback] }
  	end


  	def add_proxy
                params["method"] = params["method"].downcase
  		if params["method"].downcase != "http"
    		    return render :json => {"code" => -1, "msg" => "only need http proxy"}# don't do msg.to_json
    	        end
  		proxy_url = "%s://%s:%s" % [params["method"], params["ip"], params["port"]]
  		domains = (ProxyDomain.all.pluck(:domain) + ['zillow.com']).uniq
  		p domains
  		p domains.class
  		for domain in domains
  			proxy_domain_data = {"proxy" => proxy_url, "domain" => domain, "proxy_type" => params[:method]}
  			proxy_domain = ProxyDomain.new(proxy_domain_data).save()
  			p proxy_domain
  		end
  		proxy_data = {"proxy" => proxy_url, "proxy_type" => params[:method]}
  		proxy = Proxy.new(proxy_data).save()
  		p proxy
    	render :json => {"msg" => "ok"}# don't do msg.to_json
  	end

	def testme
  		respond_to do |format|
   			msg = { :status => "ok", :message => "Success!", :html => "<b>...</b>" }
    		format.json  { render :json => msg } # don't do msg.to_json
  		end
	end
end

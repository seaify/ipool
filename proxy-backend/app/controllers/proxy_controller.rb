require "http"
require 'uri'

class ProxyController < ApplicationController
	def proxys
		@proxys = Proxy.all
		return render :json => {:data => @proxys}, :callback => params[:callback]
  end

  def get_domain(url)
    #todo
    return "zillow.com"
  end

  def get_host_port(url)
    puts url
    #url = "http://baidu.com:80/"
    #url = "http://1.2.2.4:80/"
    uri = URI(url)
    puts uri
    return [uri.host, uri.port]
  end

	def fetch_data
    params[:url] = "https://github.com/seaify"
    proxys = $redis.zrevrange(get_domain(params[:url]), 0, 1)
    puts "hello"
    puts(proxys)
    puts "end"
    proxy = proxys[0]
    puts(proxy.class)
    puts(proxy)
    host, port = get_host_port(proxy)
    r = HTTP.via(host, port).get(params[:url])
    proxy_domain = proxy + '@' + host
    $redis.hincrby(proxy_domain, 'total', 1)
    if !$proxy_dict.has_key?(proxy_domain)
        $proxy_dict[proxy_domain] = {'total' => 0, 'succ' => 0}
        $proxy_dict[proxy_domain]['total'] = 0
        $proxy_dict[proxy_domain]['succ'] = 0
    end
    $proxy_dict[proxy_domain] = {'total' => 0, 'succ' => 0}
    puts $proxy_dict[proxy_domain]
    puts $proxy_dict[proxy_domain]['total']

    $proxy_dict[proxy_domain]['total'] += 1
    #$proxy_dict.proxy_domain.total += 1
    puts r.to_s
    if r.code == 200

      $redis.hincrby(proxy_domain, 'succ', 1)
      $proxy_dict[proxy_domain]['succ'] += 1
      $redis.zadd(host, proxy, $proxy_dict[proxy_domain]['succ'] / $proxy_dict[proxy_domain]['total'])

      return render :json => {"code" => 0, "msg" => "ok", "body" => r.to_s}# don't do msg.to_json
    else
      return render :json => {"code" => -1, "msg" => "error", "body" => "proxy failed"}# don't do msg.to_json
      end

	end

	def proxy_domains
		@proxys = ProxyDomain.all
		return render :json => {:data => @proxys, :callback => params[:callback] }
	end


	def add_proxy
    #params = {"method" => "http", "ip" => "1.2.2.3", "port" => 80}
    puts params
		params["method"] = params["method"].downcase
		if params["method"].downcase != "http"
			return render :json => {"code" => -1, "msg" => "only need http proxy"}# don't do msg.to_json
		end
		proxy_url = "%s://%s:%s/" % [params["method"], params["ip"], params["port"]]
		domains = (ProxyDomain.all.pluck(:domain) + ['zillow.com']).uniq
		p domains
		p domains.class
    $redis.hmset(proxy_url, 'total', 0)
    $redis.hmset(proxy_url, 'succ', 0)
    #$redis.hmset(proxy_url, {'total' => 0, 'succ' => 0})
		for domain in domains
			proxy_domain_data = {"proxy" => proxy_url, "domain" => domain, "proxy_type" => params[:method]}
			proxy_domain = ProxyDomain.new(proxy_domain_data).save()
			p proxy_domain
      #$redis.zadd(domain, {'total' => 0, 'succ' => 0})
      $redis.zadd(domain, 0, proxy_url)
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

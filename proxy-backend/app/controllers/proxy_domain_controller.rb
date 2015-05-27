class ProxyDomainController < ApplicationController
  def proxy_domains
    @proxy_domains = ProxyDomain.all
    respond_to do |format|
      format.json { render :json => @proxy_domains }
    end
  end

  def get_domain(url)
    #todo
    return "zillow.com"
  end

  def get_host_port(url)
    puts url
    uri = URI(url)
    puts uri
    return [uri.host, uri.port]

  end

  def get_proxy
    domain = get_domain(params[:url])
    proxys = $redis.zrevrange(domain + ':wait_use', 0, 10)
    if proxys
      proxy = proxys.sample
      return render :json => {"code" => 0, "msg" => "ok", "proxy" => proxy}
    else
      return render :json => {"code" => -1, "msg" => "no proxy for use"}
    end

  end



end

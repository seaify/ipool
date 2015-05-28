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
    record = ProxyDomain.where('in_use' =>false, 'banned' => false).order(succ_ratio: :desc).first
    if record
      return render :json => {"code" => 0, "msg" => "ok", "proxy" => record.proxy}
    else
      return render :json => {"code" => 0, "msg" => "ok", "proxy" => ENV['DEFAULT_PROXY']}
    end

  end



end

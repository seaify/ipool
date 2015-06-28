class ProxyDomainController < ApplicationController
  after_action :print_result

  def print_result
  end

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
    uri = URI(url)
    puts uri
    return [uri.host, uri.port]
  end

  def get_proxy
    domain = get_domain(params[:url])
    record = ProxyDomain.where('banned' => false).order('in_use').order(succ_ratio: :desc).first
    puts record.as_json
    if record
      #temp todo
      ProxyDomain.find_by_proxy(record.proxy).increment!(:in_use)
      return render :json => {"code" => 0, "msg" => "ok", "proxy" => record.proxy}
    else
      UserMailer.noproxy_email().deliver_now
      return render :json => {"code" => 0, "msg" => "ok", "proxy" => ENV['DEFAULT_PROXY']}
    end

  end

  def report_proxy_stats
        use_num = params[:use_num]
        proxy = params[:proxy]
        use_num.each do |domain, value|
            proxy_domain = '%s@%s' % [proxy, domain]
            result = ProxyDomain.where(proxy: proxy).first
            succ = result.succ + value['succ'].to_i
            total = result.total + value['total'].to_i
            ProxyDomain.where(proxy: proxy).first.update(:succ => succ, :total => total)
        end
        return render :json => {"code" => 0, "msg" => "thanks for your report"}
    end



end

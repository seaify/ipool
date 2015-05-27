require 'uri'

class ProxyController < ApplicationController
    def proxys
        @proxys = Proxy.all
        return render :json => {:data => @proxys}, :callback => params[:callback]
    end

    def add_proxy_api
        api_link = params[:proxyApi]
        begin
            #r = (HTTP).via(host, port).get(params[:url])
            r = Excon.get(api_link)
        rescue Exception => ex
            puts "An error of type #{ex.class} happened, message is #{ex.message}"
            return render :json => {"code" => -1, "msg" => "error", "body" => "add proxy api failed"}, :callback => params[:callback]
        end

        lines = r.body.split("\n")
        for line in lines
            host, port, user, passwd = line.gsub('\n', '').split(':')
            proxy = "http://%s:%s@%s:%s" % [user, passwd, host, port]
            add_proxy_url(proxy)
            #add proxy to redis & mysql
        end
        return render :json => {"code" => 0, "msg" => "error", "body" => "add proxy api Success"}, :callback => params[:callback]
    end

    def add_proxy_txt
        return render :json => {"code" => 0, "msg" => "error", "body" => "add proxy api Success"}, :callback => params[:callback]
    end

    def proxy_domains
        @proxys = ProxyDomain.all
        return render :json => {:data => @proxys}, :callback => params[:callback]
    end

    def allow_selected_proxy
        ProxyDomain.where(:id => params[:ids]).update_all(:banned => 0, :banned_time => nil)
        return render :json => {"code" => 0, "msg" => "set selected proxy available done"}, :callback => params[:callback]
    end


    def delete_selected_proxy
        ProxyDomain.where(:id => params[:ids]).delete_all
        return render :json => {"code" => 0, "msg" => "delete selected proxy done"}, :callback => params[:callback]
    end

    def ban_selected_proxy
        ProxyDomain.where(:id => params[:ids]).update_all(:banned => 1, :banned_time => Time.now.strftime("%Y-%m-%d %H:%M:%S"))
        return render :json => {"code" => 0, "msg" => "set selected proxy banned done"}, :callback => params[:callback]
    end

    def allow_all
        ProxyDomain.update_all(:banned => 0, :banned_time => nil)
        return render :json => {"code" => 0, "msg" => "set all proxy available done"}, :callback => params[:callback]
    end

    def ban_proxy
        ProxyDomain.where(:id => params[:ids]).update_all(:banned => 1, :banned_time => Time.now.strftime("%Y-%m-%d %H:%M:%S"))
        return render :json => {"code" => 0, "msg" => "ban selected proxy available done"}, :callback => params[:callback]
    end

    def ban_all
        ProxyDomain.update_all(:banned => 1, :banned_time => Time.now.strftime("%Y-%m-%d %H:%M:%S"))
        return render :json => {"code" => 0, "msg" => "set all proxy available done"}, :callback => params[:callback]
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

    def report_proxy_stats
        puts params
        use_num = params[:use_num]
        proxy = params[:proxy]
        use_num.each do |domain, value|
            proxy_domain = '%s@%s' % [proxy, domain]
            s = $redis.hincrby(proxy_domain, 'total', value['total'])
            f = $redis.hincrby(proxy_domain, 'succ', value['succ'])
            $redis.zadd(domain, s/f, proxy)
        end
        return render :json => {"code" => 0, "msg" => "thanks for your report"}
    end

    def add_proxy_url(proxy_url)
        method = proxy_url.split(':')[0]
        domains = (ProxyDomain.all.pluck(:domain) + ['zillow.com']).uniq

        p domains
        p domains.class

        #$redis.hmset(proxy_url, {'total' => 0, 'succ' => 0})
        for domain in domains
            response = Excon.get('http://localhost:8105/json/' + domain)
            country = JSON.parse(response.body)
            puts country
            proxy_domain_data = {"country" => country, "proxy" => proxy_url, "domain" => domain, "proxy_type" => method}
            proxy_domain = ProxyDomain.new(proxy_domain_data).save()
            p proxy_domain
            proxy_domain_url = proxy_url + '@' + domain
            $redis.hmset(proxy_domain_url, 'banned', 0)
            $redis.hmset(proxy_domain_url, 'total', 0)
            $redis.hmset(proxy_domain_url, 'succ', 0)
            #$redis.zadd(domain, {'total' => 0, 'succ' => 0})
            $redis.zadd(domain, 0, proxy_url)
        end
        proxy_data = {"proxy" => proxy_url, "proxy_type" => method}
        proxy = Proxy.new(proxy_data).save()
        p proxy

    end

    def add_proxy
        proxy_url = params[:proxy_url]
        if proxy_url.start_with?("http:")
          add_proxy_url(params[:proxy_url])
          render :json => {"msg" => "ok"} # don't do msg.to_json
        else
          render :json => {"msg" => "only accept http proxy"} # don't do msg.to_json
        end
    end

end

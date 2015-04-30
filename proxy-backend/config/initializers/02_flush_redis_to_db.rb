#require 'rufus/scheduler'

#$redis = Redis.new(:host => 'localhost', :port => 6379)
## to start scheduler
scheduler = Rufus::Scheduler.start_new

#flush redis to db
scheduler.every("30s") do
    proxy_domain_keys = $redis.keys("http:*@*")
    total_dict = {}
    succ_dict = {}
    for proxy_domain in proxy_domain_keys
        proxy, domain = proxy_domain.split('@')
        #for proxy_domain in proxy_domain_keys.slice(0, 5)

        puts(proxy)
        puts(domain)
        result = $redis.hgetall(proxy_domain)
        puts(result)
        if result['total'] == '0'
            #ProxyDomain.update_all(:succ_ratio => 0.0, :succ => result['succ'].to_i, :total => result['total'].to_i, ["proxy = ? and domain = ?", proxy, domain])
            #puts ProxyDomain.where('proxy = ? AND domain = ?', proxy, domain).limit(1)
            ProxyDomain.where('proxy = ? AND domain = ?', proxy, domain).limit(1).update_all(:succ_ratio => 0.0, :succ => result['succ'], :total => result['total'])
            #puts ProxyDomain.where(:proxy => "http://163.177.79.5:80/", :domain => "zillow.com").limit(1)
            #puts ProxyDomain.where(:proxy => proxy, :domain => domain).limit(1)
            #ProxyDomain.where(:proxy => proxy, :domain => domain).limit(1)
        else
            score = result['succ'].to_f / result['total'].to_f
            ProxyDomain.where('proxy = ? AND domain = ?', proxy, domain).limit(1).update_all(:succ_ratio => score, :succ => result['succ'], :total => result['total'])
            #ProxyDomain.where(:proxy => proxy, :domain => domain).limit(1).update_attributes(:succ_ratio => result['succ'].to_i / result['total'].to_i, :succ => result['succ'], :total => result['total'])
        end


        if !total_dict.has_key?(proxy)
            total_dict[proxy] = 0
            succ_dict[proxy] = 0
        end
        total_dict[proxy] += result['total'].to_i
        succ_dict[proxy] += result['succ'].to_i

    end
    puts(total_dict)
    puts(succ_dict)
    total_dict.each do |proxy, total|
        succ = succ_dict[proxy]
        if total == 0
            Proxy.where('proxy = ?', proxy).update_all(total: total, succ: succ, succ_ratio: 0.0)
        else
            Proxy.where('proxy = ?', proxy).update_all(total: total, succ: succ, succ_ratio: succ / total.to_f)
        end
    end
end


$redis = Redis.new(:host => 'localhost', :port => 6379)
$redis.flushall

#read db to rebuild redis
for proxy in ProxyDomain.all
    key = proxy.proxy + '@' + proxy.domain
    #puts proxy.succ.class
    $redis.hmset(key, 'succ', proxy.succ)
    $redis.hmset(key, 'total', proxy.total)
    $redis.zadd(proxy.domain, proxy.succ_ratio, proxy.proxy)
end


$redis = Redis.new(:host => 'localhost', :port => 6379)
$redis.flushall

#read db to rebuild redis
for proxy in ProxyDomain.all
    key = proxy.proxy + '@' + proxy.domain
    $redis.hmset(key, 'succ', proxy.succ)
    $redis.hmset(key, 'total', proxy.total)
    $redis.hmset(key, 'in_use', 0)
    $redis.zadd(proxy.domain + ':wait_use', proxy.succ_ratio, proxy.proxy)
end
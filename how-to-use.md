# 怎样使用ipool
分别讲解ipool的爬虫端，rails后台，爬虫前台, ip国家检测的运行方法

## 注意
下面出现过的ip，都是你运行的机器的外网ip

## 如何获取本机外网ip
在命令行下，使用curl访问下面这个站点，或者输入curl ifconfig.me
```sh
chuck@dev:/etc/supervisor/conf.d % curl http://icanhazip.com/
104.236.298.227
```

## 爬虫端
先cd到爬虫代码目录，再运行scrapy crawl proxylis
```sh
cd /home/chuck/www/ipool/proxyspiders
scrapy crawl proxylis
```
如果需要定时运行，则在crontab中添加定时任务
```sh
*/10 * * * * cd /home/chuck/www/ipool/proxyspiders && scrapy crawl proxylis
```
## 代理后台
先cd到后台代码目录，再运行rails s -b 0.0.0.0 -p 8102
```sh
cd /home/chuck/www/ipool/proxy-backend
rails s -b 0.0.0.0 -p 8102
```

验证后台api正常服务:
```sh
curl http://ip:8102/proxys.json?callback=jQuery21404667079858481884_1432801377447&_=1432801377448
```

## 爬虫前台页面
先cd到前台代码目录，再运行npm run dev
```sh
cd /home/chuck/www/ipool/proxy-frontend
npm run dev
```

查看前台页面, 访问
http://ip:8080

## [ip检测国家区域的服务](https://github.com/fiorix/freegeoip)
直接运行下面的命令
```sh
/home/chuck/www/freegeoip-3.0.4-linux-amd64/freegeoip --addr=":8105"
```

验证能正常使用:
```sh
chuck@dev:/etc/supervisor/conf.d % curl http://localhost:8105/json/94.23.78.57
{"ip":"94.23.78.57","country_code":"PT","country_name":"Portugal","region_code":"","region_name":"","city":"","zip_code":"","time_zone":"","latitude":38.714,"longitude":-9.14,"metro_code":0}

chuck@dev:/etc/supervisor/conf.d % curl http://localhost:8105/json/zillow.com
{"ip":"192.211.12.20","country_code":"US","country_name":"United States","region_code":"WA","region_name":"Washington","city":"Seattle","zip_code":"98101","time_zone":"America/Los_Angeles","latitude":47.61,"longitude":-122.335,"metro_code":819}
```


## 配置文件目录以及内容
上述所有的服务都有使用supervisord来进行进程管理, 配置文件在/etc/supervisor/conf.d目录.
```sh
chuck@dev:/etc/supervisor/conf.d % cat freegeoip.conf
[program:freegeoip]
command=/home/chuck/www/freegeoip-3.0.4-linux-amd64/freegeoip --addr=":8105"
directory=/home/chuck/www/freegeoip-3.0.4-linux-amd64/
user=chuck
```

```sh
chuck@dev:/etc/supervisor/conf.d % cat proxy.backend.conf
[program:proxy.backend]
command=/usr/local/bin/unicorn -p 8102
directory=/home/chuck/www/ipool/proxy-backend
environment=RAILS_ENV="development",HOME="/home/chuck"
user=chuck
autorestart=false
```

```sh
chuck@dev:/etc/supervisor/conf.d % cat proxy.frontend.conf
[program:proxy.frontend]
command=/usr/local/bin/npm run dev
directory=/home/chuck/www/ipool/proxy-frontend
user=chuck
```
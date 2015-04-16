# ipool
提供公开代理ip的抓取，以及代理的管理后台，以及代理的展示后台。
目前是使用scrapy来抓取http://proxylist.hidemyass.com ，上的公开代理，使用flask来管理抓取到的代理，以及对其它爬虫提供代理服务，使用react + flux来管理代理的后台页面。
但正在做迁移，代理后台决定由flask改版为rails，开发进行中。

## [proxyspiders](proxyspiders)
对网络上公开代理的网站进行抓取，提取公开代理供自己使用，目前抓取了http://proxylist.hidemyass.com/ ， 后续估计会增加新的抓取站点如usproxy。

## [proxy-frontend](proxy-frontend)
使用[react](https://facebook.github.io/react/)和[flux](http://facebook.github.io/flux/docs/overview.html), 以及[react-bootstrap](http://react-bootstrap.github.io/components.html) 和[proxy-backend](proxy-backend)提供的api服务，进行网页展示和用户交互

## [proxy-backend](proxy-backend)
目前正常工作的版本使用的是[flask](http://flask.pocoo.org/), 但正在将代码改版为rails

## 后续
将会为这3个子项目分别更新README.md，以及分别放出demo页面，方便大家测试使用
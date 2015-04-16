from scrapy import log
from scrapy.http import Request
import random
import time


class InitRequest(object):

    def __init__(self, settings):
        self.proxy_dict = {}
        with open('books_spider/proxy.list') as fd:
            for x in fd:
                self.proxy_dict[x.strip()] = 100.0
        self.proxy_dict['http://localhost:8087/'] = 10.0

    @classmethod
    def from_crawler(cls, crawler):
        return cls(crawler.settings)

    def process_request(self, request, spider):
        print('number of proxys is %d' % len(self.proxy_dict))
        proxys = sorted(self.proxy_dict.items(), key=lambda x: x[1])
        request.meta['proxy'] = random.choice(proxys[0:60])[0]
        print('current proxy is %s' % request.meta['proxy'])

    def process_response(self, request, response, spider):
        if response.status != 200:
            print(response.status)
            self.proxy_dict[request.meta['proxy']] = 1000.0
            return Request(request.url)
        print(request.meta.get('download_latency'))
        self.proxy_dict[request.meta['proxy']] = \
            request.meta['download_latency']
        return response

    def process_exception(self, request, exception, spider):
        print('hello ' + str(exception))
        del self.proxy_dict[request.meta['proxy']]
        return Request(request.url)

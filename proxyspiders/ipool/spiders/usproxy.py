# -*- coding: utf-8 -*-
import scrapy


class UsproxySpider(scrapy.Spider):
    name = "usproxy"
    allowed_domains = ["usproxy.com"]
    start_urls = (
        'http://www.usproxy.com/',
    )

    def parse(self, response):
        pass

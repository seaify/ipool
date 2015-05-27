# -*- coding: utf-8 -*-
import scrapy
import requests
import json
from bs4 import BeautifulSoup
from scrapy import log
from scrapy.http import Request

def fetch_value_in_dict(s_array, s_dict):
    if not s_array:
        return "not-found"
    for s in s_array:
        if s in s_dict:
            return s_dict[s]
    return "not-found"

def get_ip(span):
    styles = span.find('style').get_text().split('.')
    style_dict = {style.split('{')[0]: style.split(':')[-1].replace('}', '').strip() for style in styles[1:]}
    ip = ''
    index = 0
    for child in span.children:
        if index == 0:
            index += 1
            continue
        if not hasattr(child, 'get'):
            ip += child
            continue
        class_value = fetch_value_in_dict(child.get('class'), style_dict)
        if class_value == "none":
            continue
        style_str = child.get('style')
        if style_str and style_str.replace(' ', '') == 'display:none':
            continue
        ip += child.get_text()
    return ip


class ProxylisSpider(scrapy.Spider):
    name = "proxylis"
    allowed_domains = ["proxylis.com"]
    BASE_URL = "http://104.236.131.39:8102"
    #start_urls = ["http://proxylist.hidemyass.com/" + str(i) + "#listable" for i in range(1, 21)]

    def start_requests(self):
        #for i in range(1, 2):
        for i in range(1, 21):
            url = "http://proxylist.hidemyass.com/" + str(i) + "#listable"
            yield Request(url)


    def parse(self, response):
        soup = BeautifulSoup(response.body)
	#print soup
	#print soup.find('table').find('tbody')
        trs = soup.find('table', id="listable").find('tbody').find_all('tr')
        for tr in trs:
            #print t
	    tds = tr.find_all('td')
            ip = get_ip(tds[1].find('span')).strip()
	    port = tds[2].get_text().strip()
	    method = tds[6].get_text().strip()
            headers = {'Content-type': 'application/json', 'Accept': 'text/plain'}
            proxy = "%s://%s:%s/" % (method.lower(), ip, port)
            data = {"proxy_url": proxy}
            print data
            print proxy
            r = requests.post(self.BASE_URL + '/add_proxy', data=json.dumps(data), headers=headers)
            print r.text

        pass

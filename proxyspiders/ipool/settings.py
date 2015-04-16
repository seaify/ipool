# -*- coding: utf-8 -*-

# Scrapy settings for ipool project
#
# For simplicity, this file contains only the most important settings by
# default. All the other settings are documented here:
#
#     http://doc.scrapy.org/en/latest/topics/settings.html
#

BOT_NAME = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'

DOWNLOAD_DELAY = 20

SPIDER_MODULES = ['ipool.spiders']
NEWSPIDER_MODULE = 'ipool.spiders'

# Crawl responsibly by identifying yourself (and your website) on the user-agent
#USER_AGENT = 'ipool (+http://www.yourdomain.com)'
COOKIES_ENABLED = False
RETRY_TIMES = 2
'''
DOWNLOADER_MIDDLEWARES = {
    'ipool.middlewares.ReloadRequest': 50,
}
'''

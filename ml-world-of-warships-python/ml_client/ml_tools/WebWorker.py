__author__ = 'Monstrofil'

import urllib, os
import sys, ml_tools.Logger
Logger = sys.modules['ml_tools'].Logger
import threading
from Queue import Queue



class QueryLinkElement(object):
    def __init__(self, url, callback):
        self.callback = callback
        self.url = url


class WebWorker(threading.Thread):
    def __init__(self):
        super(WebWorker, self).__init__()
        self.queue = Queue()

    def run(self):
        while True:
            queryFileElement = self.queue.get()
            try:
                self.__download_url(queryFileElement)
            except Exception, e:
                Logger.LOG("Error")
                Logger.LOG(e)
            self.queue.task_done()

    def __download_url(self, queryFileElement):
        Logger.LOG("[%s] Downloading %s"%(self.ident, queryFileElement.url))
        queryFileElement.callback(urllib.urlopen(queryFileElement.url).read())



g_webWorker = WebWorker()
g_webWorker.start()
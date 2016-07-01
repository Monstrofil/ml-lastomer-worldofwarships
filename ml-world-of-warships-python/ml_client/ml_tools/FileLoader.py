__author__ = 'Monstrofil'
import urllib, os
import sys
import ml_tools.Logger
Logger = sys.modules['ml_tools'].Logger
import threading
from Queue import Queue



class QueryFileElement(object):
    def __init__(self, name, url, callback=None):
        self.name = name
        self.url = url
        self.callback = callback


class FileLoader(threading.Thread):
    def __init__(self, root=''):
        super(FileLoader, self).__init__()
        self.queue = Queue()
        self.root = root

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
        Logger.LOG("[%s] Downloading %s -> %s"%(self.ident, queryFileElement.url, self.root))
        urllib.urlretrieve(queryFileElement.url, os.path.join(self.root, queryFileElement.name))

        print 'CALLBACK', queryFileElement.callback

        if queryFileElement.callback:
            queryFileElement.callback()



g_fileLoader = FileLoader()


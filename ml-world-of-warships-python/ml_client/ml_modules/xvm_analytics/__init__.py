UUIDFILE = "UUIDFILE.DATA"

tid = 'UA-57419165-5'
description = 'XVM_LASTOMER'
author = 'by Monstrofil & z1ooo & Hootorez'
version = 'v6.0 (with site auth)'

try:
    UID = open(UUIDFILE, 'rb').read()
except:
    import uuid
    UID = str(uuid.uuid1())
    with open(UUIDFILE, 'wb') as f:
        f.write(UID)
finally:
    import urllib, GUI, threading
    def track_installation():
        param = urllib.urlencode({
            'v': 1,
            'tid': '%s' % tid,
            'cid': UID,
            't': 'screenview',
            'an': '%s' % description,
            'av': '%s %s' % (description, version),
            'sr': '%sx%s' % GUI.screenResolution(),
            'cd': '[XVM] LOADING',
        })
        urllib.urlopen(url='http://www.google-analytics.com/collect?', data=param).read()
    threading.Thread(target=track_installation, name='track_installation').start()

    import Avatar
    def track_server_thread():
        import BigWorld
        print 'track_server_thread', BigWorld.server()
        param = urllib.urlencode({
            'v': 1,
            'tid': '%s' % tid,
            'cid': UID,
            't': 'screenview',
            'an': '%s' % description,
            'av': '%s %s' % (description, version),
            'sr': '%sx%s' % GUI.screenResolution(),
            'cd': '[XVM] start battle',
            'ul': BigWorld.server()
        })
        urllib.urlopen(url='http://www.google-analytics.com/collect?', data=param).read()

    def track_server(*args):
        threading.Thread(target=track_server_thread, name='track_server_thread').start()
    Avatar.gAvatarEnteredWorld += track_server



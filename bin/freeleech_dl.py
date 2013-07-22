#!/usr/bin/env python2
# encoding: utf-8
# freeleech_dl.py by tobbez
import json
import requests
import HTMLParser
import os
import re
from getpass import getpass

def download_torrent(session, tid, name):
    if not os.path.exists('downloaded_torrents/'):
        os.mkdir('downloaded_torrents')

    path = os.path.join('downloaded_torrents/', name)
    if os.path.exists(path):
        print '{} already downloaded, skipping'.format(tid)
        return

    if not hasattr(download_torrent, 'authdata'):
        r = session.get('https://what.cd/ajax.php?action=index')
        d = json.loads(r.content)
        download_torrent.authdata = '&authkey={}&torrent_pass={}'.format(d['response']['authkey'], d['response']['passkey'])

    print 'Downloading {}...'.format(tid),
    dl = session.get('https://what.cd/torrents.php?action=download&id={}{}'.format(tid, download_torrent.authdata))
    with open(path, 'wb') as f:
        for chunk in dl.iter_content(1024*1024):
            f.write(chunk)
    print 'Done'

def main():

    ### You can change the following values if you only want to download a
    ### subset of all freeleech torrents, or if you don't want to enter your
    ### username and/or password every time you run the script.

    user = raw_input("What.CD Username: ")
    password = getpass("What.CD Password: ")
    search_params = 'search=&freetorrent=1'
    
    ### No need to change anything below this line
    
    html_parser = HTMLParser.HTMLParser()
    fcre = re.compile('''[/\\?*:|"<>]''')
    clean_fn = lambda x: fcre.sub('', html_parser.unescape(x))

    s = requests.session()
    
    r = s.post('https://what.cd/login.php', data={'username': user, 'password': password})
    if r.url != u'https://what.cd/index.php':
        print "Login failed"
        return

    page = 1
    while True:
        r = s.get('https://what.cd/ajax.php?action=browse&' + search_params + "&page={}".format(page))
        data = json.loads(r.content)
        for group in data['response']['results']:
            if 'torrents' in group:
                for torrent in group['torrents']:
                    if not torrent['isFreeleech']:
                        continue
                    fn = clean_fn('{}. {} - {} - {} ({} - {} - {}).torrent'.format(torrent['torrentId'], group['artist'][:50], group['groupYear'], group['groupName'][:50], torrent['media'], torrent['format'], torrent['encoding']))
                    download_torrent(s, torrent['torrentId'], fn)
            else:
                fn = clean_fn('{}. {}.torrent'.format(group['torrentId'], group['groupName'][:100]))
                download_torrent(s, group['torrentId'], fn)

        page += 1
        if page > data['response']['pages']:
            break

    print "Done"
    

if __name__ == '__main__':
    main()

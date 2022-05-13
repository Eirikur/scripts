import json

# profile = 'g7jul1fc'
profile = 'pph9z6ra.current-default-1626240028911'

f= open(f'~/.mozilla/firefox/{profile}.default/sessionstore-backups/recovery.js' )

jdata = json.loads(f.read())

f.close()

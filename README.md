nullworks-ss
============

Ruby based secure shell wrapper using JSON

This is a script I use to jump to different servers I manage.
I wrote this script because a lot of the time I'm connected to one or more VPN's and DNS name resolution isn't always possible. I also might want to use different usernames or host keys, or setup a SSH tunnel. This script can do all of that.

## WARNING:

It's not perfect, far from it I'm sure, one issue I know of that I haven't fixed is when trying to use SSH tunnels you have to make a match to a name exact, or at least exact enough that only one match is made. There's a bug in the way the menu is made that breaks the arg passing to SSH.

Also note that I name the script ss as short hand for ssh. There's already an existing command on linux called ss (socket statistics), so if you don't use it or care, feel free to use the ss name, it does make it a quick command to use.

## USE:

To use the script the following is done:
* Create a file called servers.txt in a directory called Servers (you can change this if you want and mod the scripts)
* Add server lines that follow this pattern: NAME,CONN,OPTIONS
* Run the mkjson.rb script
* Connect to a server with: ss NAME

## EXAMPLES:

### CONN - represents the connection which can be in a few forms, examples:
IP - 10.0.0.10
USER@IP - user@10.0.0.10
IP:PORT - 10.0.0.10:2222
USER@IP:PORT - user@10.0.0.10:2222

### NAME - is a more than a hostname, but a pattern to be used to represent the connection, examples:
SERVER - testserver
USER.SERVER - user.testserver
SERVICE.SERVER - vnc1.testserver

### OPTIONS - these are ssh options passed through
Tunneling - '-L 5901:127.0.0.1:5901'
Hostkeys - '-i/path/to/mykey'

### CONN STRINGS:
testserver,10.0.0.10
user.testserver,user@10.0.0.10
vnc1.testserver,user@10.0.0.10,'-L 5901:127.0.0.1:5901'
key.testserver,user@10.0.0.10,'-i/path/to/mykey'

After running the mkjson.rb you can connect to any of the connections above using regex patterns:

ss test - matches all 4 and gives a menu with numbers to pick
ss u t - matches user.testserver only
ss vnc - matches vnc1.testserver only

That's the basics.

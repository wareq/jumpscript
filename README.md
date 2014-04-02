Jumpscript
============

1. Create servers list

{
	"name":	{
		"user"   : "optional__user", 
		"ip"     : "host_or_ip", 
		"port"   : 22, 
		"id_rsa" : "optional__path_to_rsa_key", 
		"args"   : "optional__additional arguments"
	},
	"DEV example":	{
		"user"   : "www-data", 
		"ip"     : "my-server-dev.example.com", 
		"port"   : 22, 
		"id_rsa" : "/Users/wareq/.ssh/id_rsa", 
		"args"   : "-v"
	},
	"TEST example":	{
		"user"   : "www-data", 
		"ip"     : "my-server-test.example.com", 
		"port"   : 22, 
		"id_rsa" : "/Users/wareq/.ssh/id_rsa", 
		"args"   : "-v"
	}
}

2. Call the jumpscript

> ss example

The script will ask you which of the server you would like to connect:

 1. DEV example ( www-data@my-server-dev.example.com:22 )
 2. TEST example ( www-data@my-server-test.example.com:22 )
 Enter a number for a server ( or q to quit ): 

> ss dev example

Only one server match the pattern. The Script will direct connect you to my-server-dev.example.com

3. What has changed?

This is fork of nullworks-ss project. Changes:
* The code has been cleaned up
* "Connect" method was extracted
* New "id_rsa" parameter in servers.json
* I have resigned from converting csv to json. If you would like to add new host please edit servers.json file.
* Flow of the script was changed. Get connection name (or its parts) only from script execution arguments. Don't prompt for it.
* Texts and colors has changed little 
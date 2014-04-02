#!/usr/bin/env ruby
=begin
Copyright 2014 Wareq
Fork of: https://github.com/koaps/nullworks-ss

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Run:
 ss [NAME]

Looking for connections that fit your name. 
* If there are only one record you will be immediately connected to pointed host
* For more records the script will prompt you for which connection you meant
=end

servers_path = 'servers.json'

require 'json'
json = File.read(servers_path)
s = JSON.parse(json)

input = ARGV

p = String.new
input.each { |i|
    p += i.to_s + '.*'
}

m = s.keys.grep(/#{p}/i)

conn = ''

def connect(name, user, ip, port, args, id_rsa)
    puts "\033[0;32;mConnecting to " + name + " ( \033[1;32;m" + user + "@" + ip + ":" + port + "\033[0;32;m ) \033[0m"
        conn = "ssh -l " + user + " -p" + port + " " + ip
    if !id_rsa.empty?
        puts "\033[0;32;mUse rsa key: \033[1;32;m" + id_rsa + "\033[0;32;m \033[0m"
        conn = conn + " -i" + id_rsa
    end
    if !args.empty?
        puts "\033[0;32;mArgs: \033[1;32;m" + args + "\033[0;32;m \033[0m"
        conn = conn + " " + args
    end

    system conn
end

if m.count == 1
    connect("#{m[0]}", "#{s[m[0]]['user']}", "#{s[m[0]]['ip']}", "#{s[m[0]]['port']}", "#{s[m[0]]['args']}", "#{s[m[0]]['id_rsa']}" )
elsif m.count > 1
    i = 1
    puts "Found \033[1;37;m #{m.count} \033[0m matches"
    m.each { |svr|
    puts "\033[1;37;m #{i}. \033[0m#{svr} ( #{s[svr]['user']}@#{s[svr]['ip']}:#{s[svr]['port']} )"
    i += 1
    }
    puts "\033[1;37;44m Enter a number for a server ( or q to quit ): \033[0m"
    input = STDIN.gets.chomp.to_i
    if !(1..m.count).include?(input) ; puts "\033[1;31;47m Exiting...\033[0m"; exit end
    connect("#{m[input -1]}", "#{s[m[input - 1]]['user']}", "#{s[m[input - 1]]['ip']}", "#{s[m[input - 1]]['port']}", "#{s[m[input - 1]]['args']}", "#{s[m[input - 1]]['id_rsa']}" )    
else
    puts "\033[7;31;47m No matches found \033[0m"
    exit
end

system conn

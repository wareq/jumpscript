#!/usr/bin/env ruby

=begin
Copyright 2013 Koaps / Nullworks
http://nullworks.wordpress.com

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
=end

require 'json'

servers_file='/path/to/Servers/servers.txt'
servers_json_file='/path/to/Servers/servers.json'
default_user='testuser'
default_port = 22

jh = Hash.new

sfile = Array.new
sfile = IO.readlines(servers_file)
sfile.each { |l|
    l.strip!
    next if l.match('^;')
    next if l.match('^$')

    user = default_user
    port = default_port

    (name,connstr,args) = l.split(',')

    if connstr.match('@')
        (user,ip) = connstr.split('@')
    else
        ip = connstr
    end
    if ip.match(':') ; (ip,port) = ip.split(':') end

    jh[name] = {'user' => user, 'ip' => ip, 'port' => port.to_i, 'args' => args}
}

File.open(servers_json_file,"w") do |f|
  f.write(jh.to_json)
end

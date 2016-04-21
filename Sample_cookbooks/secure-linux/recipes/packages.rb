# encoding: utf-8
#
# Cookbook Name: os-hardening
# Recipe: packages.rb
#
# Copyright 2014, Deutsche Telekom AG
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# do package config for ubuntu
case node['platform_family']
  when 'debian', 'ubuntu'
    %w(telnet rsh tftp tftp-server talk talk-server xinetd inetd ypserv telnet-server rsh-server wget nmap finger rlogin ftp).each do |pkg|
      package pkg do
        action :purge
      end
  end
  when 'rhel', 'centos', 'fedora'
    %w(dhcp telnet rsh tftp tftp-server talk talk-server xinetd inetd ypserv telnet-server rsh-server wget nmap finger rlogin ftp).each do |pkg|
      yum_package pkg do
        action :purge
      end
    end
end

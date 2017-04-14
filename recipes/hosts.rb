#
# Cookbook:: networker
# Recipe:: hosts
#
# Copyright:: 2017, The Authors, All Rights Reserved.

hosts = { 'server-centos-72' => '10.10.10.10',
          'client-centos-72' => '10.10.10.20',
          'client-mwrock-Windows2012R2' => '10.10.10.30',
}

hosts.each { |host,ip|
  hostsfile_entry ip do
    hostname host
    unique true
  end
}

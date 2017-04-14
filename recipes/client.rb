#
# Cookbook:: networker
# Recipe:: client
#
# Copyright:: 2017, The Authors, All Rights Reserved.

case node['platform_family']
when 'windows'
  package node['nw']['client']['package'] do
    source "#{node['nw']['client']['path']}\#{node['nw']['client']['package']}"
    installer_type :custom
    options '/s /v /q InstallLevel=100'
    action :install
  end
when 'rhel'
  package node['nw']['client']['package'] do
    source "#{node['nw']['client']['path']}/#{node['nw']['client']['package']}"
    action :install
    notifies :start, 'service[networker]', :immediately
  end

  service 'networker' do
    action :nothing
  end
end

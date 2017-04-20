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

# NOTE: This will create duplicate clients by default; need to add code to the
#       custom resource to handle that for us
networker 'create_client' do
  client_name node['hostname'].to_s
  save_sets node['nw']['client']['savesets']
  protection_groups node['nw']['client']['protection_groups']
  only_if { node['nw']['client']['create'] }
end

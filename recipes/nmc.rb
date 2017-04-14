#
# Cookbook:: networker
# Recipe:: nmc
#
# Copyright:: 2017, The Authors, All Rights Reserved.

group node['nw']['nmc']['db_group'].to_s do
  gid '1002'
  action :create
end

user node['nw']['nmc']['db_user'].to_s do
  comment 'Postgres user for NetWorker Management Console'
  uid '1002'
  gid '1002'
  action :create
  not_if { node['etc']['passwd']['nsrtomcat'] }
end

package node['nw']['nmc']['package'].to_s do
  source "#{node['nw']['install_source']}/#{node['nw']['nmc']['package']}"
  action :install
end

template "#{Chef::Config[:file_cache_path]}/nmc_config_response" do
  source 'nmc_config_response.erb'
  action :create
#  notifies :run, 'execute[configure_nmc]', :immediately
end

# execute 'configure_nmc' do
#   command "/opt/lgtonmc/bin/nmc_config -silent #{Chef::Config[:file_cache_path]}/nmc_config_response"
#   action :run
# end

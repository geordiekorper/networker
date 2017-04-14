#
# Cookbook:: networker
# Recipe:: server
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'java::default'

node['nw']['server_packages'].each do |package|
  package package.to_s do
    source "#{node['nw']['install_source']}/#{package}"
    action :install
  end
end

template "#{Chef::Config[:file_cache_path]}/authc_config_response" do
  source 'authc_config_response.erb'
  action :create
end

group node['nw']['emc_tcgroup'].to_s do
  gid '1001'
  action :create
end

user node['nw']['emc_tcuser'].to_s do
  comment 'Tomcat user for EMC Tomcat'
  uid '1001'
  gid '1001'
  action :create
  not_if { node['etc']['passwd']['nsrtomcat'] }
end

execute 'authc_configure.sh' do
  command "/opt/nsr/authc-server/scripts/authc_configure.sh -silent #{Chef::Config[:file_cache_path]}/authc_config_response"
  not_if { node['etc']['passwd']['nsrtomcat'] }
end

service 'networker' do
  action :start
end

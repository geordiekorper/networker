#
# Cookbook:: networker
# Recipe:: backup
#
# Copyright:: 2017, The Authors, All Rights Reserved.

networker 'do_backup' do
  client_name node['hostname'].to_s
  policy node['nw']['client']['policy'].to_s
  workflow node['nw']['client']['workflow'].to_s
  action :backup
end

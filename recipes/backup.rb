#
# Cookbook:: networker
# Recipe:: backup
#
# Copyright:: 2017, The Authors, All Rights Reserved.

networker 'do_backup' do
  client_name node['hostname'].to_s
  save_sets node['nw']['client']['savesets']
  protection_groups node['nw']['client']['protection_groups']
  action :backup
end

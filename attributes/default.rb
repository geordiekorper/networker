# Prerequisite default attributes
default['java']['jdk_version'] = 8

# NetWorker install default attributes
default['nw']['install_source'] = '/tmp/omnibus/cache/networker/linux_x86_64'
default['nw']['server_packages'] = ['lgtoclnt-9.1.0.2-1.x86_64.rpm',
                                    'lgtoxtdclnt-9.1.0.2-1.x86_64.rpm',
                                    'lgtonode-9.1.0.2-1.x86_64.rpm',
                                    'lgtoauthc-9.1.0.2-1.x86_64.rpm',
                                    'lgtoserv-9.1.0.2-1.x86_64.rpm',
                                    'lgtoman-9.1.0.2-1.x86_64.rpm']
default['nw']['emc_javadir'] = '/usr/lib/jvm/java-1.8.0'
default['nw']['emc_tcuser'] = 'nsrtomcat'
default['nw']['emc_tcgroup'] = 'nsrtomcat'
default['nw']['emc_tcport'] = 9090
default['nw']['emc_createtckeystore'] = 'y'
default['nw']['emc_tckeystore'] = '/nsr/authc/conf/authc.keystore'
default['nw']['emc_tckeypassword'] = 'changeit' # Change or vault this!
default['nw']['emc_localadmin_password'] = 'Password1!' # Change or vault this!
default['nw']['emc_datadir'] = '/nsr/authc/data'

# NetWorker Management Console default attributes
default['nw']['nmc']['package'] = 'lgtonmc-9.1.0.2-1.x86_64.rpm'
default['nw']['nmc']['create_db_user'] = 'N'
default['nw']['nmc']['db_user'] = 'postgres'
default['nw']['nmc']['db_pwd'] = 'Cod3Can!' # Change or vault this!
default['nw']['nmc']['db_group'] = 'postgres'
default['nw']['nmc']['httpd_user'] = 'nobody'
default['nw']['nmc']['httpd_group'] = 'nobody'
default['nw']['nmc']['httpd_port'] = 9000
default['nw']['nmc']['db_port'] = 5432
default['nw']['nmc']['gst_port'] = 9001
default['nw']['nmc']['overwrite_nmcdb'] = 'N'
default['nw']['nmc']['db_path'] = '/nsr/nmc/nmcdb'
default['nw']['nmc']['authhost'] = 'server-centos-72'
default['nw']['nmc']['auth_port'] = default['nw']['emc_tcport']
default['nw']['nmc']['restart_services'] = 'N'

# NetWorker Client install default attributes
case node['platform_family']
when 'windows'
  default['nw']['client']['path'] = 'C:\omnibus\cache\networker\win_x64\networkr'
  default['nw']['client']['package'] = 'lgtoclnt-9.1.0.2.exe'
when 'rhel'
  default['nw']['client']['path'] = '/tmp/omnibus/cache/networker/linux_x86_64'
  default['nw']['client']['package'] = 'lgtoclnt-9.1.0.2-1.x86_64.rpm'
end
default['nw']['client']['create'] = true
default['nw']['client']['do_backup'] = true
default['nw']['client']['savesets'] = ['All']
# Default ProtectionGroups have names of <policy>-<workflow>; however that
# is not guaranteed to be true so we provide attributes for all three
default['nw']['client']['protection_groups'] = ['Bronze-Filesystem']
default['nw']['client']['policy'] = 'Bronze'
default['nw']['client']['workflow'] = 'Filesystem'

# NetWorker REST API default attributes
default['nw']['api']['server'] = 'server-centos-72'
default['nw']['api']['port'] = default['nw']['emc_tcport'].to_s
default['nw']['api']['version'] = 'v2'
default['nw']['api']['user'] = 'administrator'
default['nw']['api']['pwd'] = default['nw']['emc_localadmin_password'].to_s
default['nw']['api']['header_type'] = 'Content-Type: application/json'
default['nw']['api']['header_auth'] = 'Authorization: Basic'
default['nw']['api']['uri'] = "https://#{default['nw']['api']['server']}:#{default['nw']['api']['port']}/nwrestapi/#{default['nw']['api']['version']}"

# NetWorker Cookbook

The NetWorker Cookbook is both a regular and library cookbook.  It provides a `networker` custom resource that serves as an example for interacting with the NetWorker REST API.

Additionally, the cookbook provides sample recipes for using the custom resource.  These recipes are heavily attribute driven.

## Scope

This cookbook is concerned with Dell/EMC corporation's proprietary commercial data protection software called NetWorker.  This software which must be procured directly from Dell/EMC.

## Requirements

* Chef 12.5+
* Dell/EMC NetWorker 9.1+

### Platform Support

The following platforms have been tested with Test Kitchen:

NetWorker Server:

* CentOS-7.2

NetWorker Client:

* CentOS-7.2

## Cookbook Dependencies

This cookbook has the following dependencies:

* java
* hostsfile (for TestKitchen only)

## Usage

Place a dependency on the `networker` cookbook in your cookbook's `metadata.rb`

```Ruby
depends 'networker`
```

Then, in a recipe:

```Ruby
networker 'create-client' do
  client_name 'my-client.foo.bar'
  server_name 'networker-server.foo.bar'
  save_sets ['All']
  protection_groups ['Bronze-Filesystem']
  action :create
end
```

This will create a client named `my-client.foo.bar` on the NetWorker server `networker-server.foo.bar`.  This client will have a saveset of `All` and will be placed in the `Bronze-Filesystem` protection group.

## Attributes
See `attributes/default.rb` for default values.

Prerequisite Attributes:

* `default['java']['jdk_version']` - JRE (specifically v8) is a prerequisite for the NMC

### NetWorker Installation Default Attributes

* `default['nw']['install_source']`- Packages required for server installation

The attributes below populate the response file required for the silent configuration of NetWorker's built-in authorization service.  Configuration of LDAP authentication should be done after installation but is out-of-scope for this cookbook.

* `default['nw']['emc_javadir']` - Should point to JAVA_HOME
* `default['nw']['emc_tcuser']` - Default tomcat user
* `default['nw']['emc_tcgroup']` - Default tomcat group
* `default['nw']['emc_tcport']` - Default port
* `default['nw']['emc_createtckeystore']` - Create tomcat keystore
* `default['nw']['emc_tckeystore']` - Tomcat keystore location
* `default['nw']['emc_tckeypassword']` - Tomcat keystore password
* `default['nw']['emc_localadmin_password']` - Default NetWorker 'administrator' password
* `default['nw']['emc_datadir']` - Default authentication service data location

### NetWorker Management Console Default Attributes

* `default['nw']['nmc']['package']` - Installation package for the NMC
* `default['nw']['nmc']['db_user']` - NMC database user
* `default['nw']['nmc']['db_group']` - NMC database group
* `default['nw']['nmc']['db_pwd']` - NMC database password
* `default['nw']['nmc']['authhost']` - Server hosting NetWorker's authc service; usually the NetWorker server

### NetWorker Client install default attributes

* `default['nw']['client']['path']` - Location of NetWorker client installation binaries
* `default['nw']['client']['package']` - Name of NetWorker client installation package
* `default['nw']['client']['create']` - Create a client entry on the NetWorker server during installation?
* `default['nw']['client']['do_backup']` - Run an intial backup of the client after installation and creation?
* `default['nw']['client']['savesets']` - An array of savesets for the client

Default ProtectionGroups have names of <policy>-<workflow>; however that is not guaranteed to be true so we provide attributes for all three,

* `default['nw']['client']['protection_groups']` - Array of protection groups for the client
* `default['nw']['client']['policy']` - Policy name for the client (used for `:backup` action)
* `default['nw']['client']['workflow']` - Workflow contained within the policy (used for `:backup` action)

### NetWorker REST API default attributes

* `default['nw']['api']['server']` - Name of the NetWorker server
* `default['nw']['api']['port']` - Port to use (defaults to `default['nw']['emc_tcport']` above)
* `default['nw']['api']['version']` - API version to use
* `default['nw']['api']['user']` - User account for authorization
* `default['nw']['api']['pwd']` - Password for authorization (defaults to `default['nw']['emc_localadmin_password']` above)
* `default['nw']['api']['header_type']` - Content-Type to use; provided for future compatibility
* `default['nw']['api']['header_auth']` - Authorization type to use; provided for future compatibility
* `default['nw']['api']['uri']` - Default URI for access to API; constructed from other REST API attributes; provided for convenience

## Recipes

### default

### hosts

### server

### nmc

### client

### backup

## Resource Overview

### networker

## networker::server

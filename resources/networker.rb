resource_name :networker

property :client_name, String, default: node['hostname']
property :server_name, String, default: node['nw']['api']['server']
property :save_sets, Array
property :protection_groups, Array
property :policy, String, default: node['nw']['client']['policy']
property :workflow, String, default: node['nw']['client']['workflow']

default_action :create

require 'net/http'
require 'json'
require 'base64'

action :create do
  if client_exists?
    puts
    Chef::Log.warn("A client with name #{client_name} was found on server #{server_name}")
    Chef::Log.warn("You should verify the configuration of client #{client_name} on NetWorker server #{server_name}")
  else
    # Create a new client
    converge_by("Create new client #{new_resource.client_name} on NetWorker server #{server_name}") do

      uri = URI.parse("#{node['nw']['api']['uri']}/global/clients")
      token = Base64.encode64("#{node['nw']['api']['user']}:#{node['nw']['api']['pwd']}")

      header = {
        'Content-Type' => 'application/json',
        'Authorization' => "Basic #{token}",
      }

      message = {
        'hostname' => client_name.to_s,
        'saveSets' => save_sets,
        'protectionGroups' => protection_groups,
      }

      # Create the HTTP objects
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE # This is bad! You should use a valid cert and verify it
      request = Net::HTTP::Post.new(uri.request_uri, header)
      request.body = message.to_json

      # Send the request
      response = http.request(request)

      response.code

    end
  end
end

action :backup do
  converge_by("Starting requested backup of client #{client_name} on NetWorker server #{server_name}") do

    uri = URI.parse("#{node['nw']['api']['uri']}/global/protectionpolicies/#{policy}/workflows/#{workflow}/op/backup")

    token = Base64.encode64("#{node['nw']['api']['user']}:#{node['nw']['api']['pwd']}")

    header = {
      'Content-Type' => 'application/json',
      'Authorization' => "Basic #{token}",
    }

    message = {
      'clients' => [client_name.to_s],
    }

    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE # This is bad! You should use a valid cert and verify it
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = message.to_json

    # Send the request
    response = http.request(request)

    response.code

  end
end

action_class.class_eval do
  def client_exists?
    # TODO: Code that actually checks if #{client_name} exists on #{server_name}
    uri = URI.parse("#{node['nw']['api']['uri']}/global/clients?fl=aliases,hostname,savesets,protectiongroups&q=hostname:#{client_name}")
    token = Base64.encode64("#{node['nw']['api']['user']}:#{node['nw']['api']['pwd']}")

    header = {
      'Content-Type' => 'application/json',
      'Authorization' => "Basic #{token}",
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE # This is bad! You should use a valid cert and verify it
    request = Net::HTTP::Get.new(uri, header)
    response = http.request(request)

    client_list = JSON.parse(response.body)

    if client_list['count'].zero?
      false
    else
      true
    end
  end
end

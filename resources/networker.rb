resource_name :networker

property :client_name, String
property :save_sets, Array
property :protection_groups, Array

# TODO: Convert to use rest-client instead of net/http to simplify
require 'net/http'
require 'uri'
require 'json'
require 'base64'

action :create do
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

  uri = URI.parse("#{node['nw']['api']['uri']}/global/clients")

  # Create the HTTP objects
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE # This is bad! You should use a valid cert and verify it
  request = Net::HTTP::Post.new(uri.request_uri, header)
  request.body = message.to_json

  # Send the request
  response = http.request(request)

  # 201 means success
  return 0 unless response.code != 201

end

action :backup do
  # TODO: Stuff to initate an initial, on-demand backup
end

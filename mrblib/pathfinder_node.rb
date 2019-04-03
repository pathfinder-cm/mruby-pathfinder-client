require(File.expand_path('node', File.dirname(__FILE__)))

module Pathfinder
  class PathfinderNode
      def initialize(opts = {})
        opts[:scheme] ||= 'http'
        opts[:address] ||= 'localhost'
        @client = SimpleHttp.new(opts[:scheme], opts[:address], opts[:port])
      end

    def register(cluster_name:, cluster_password:, node:)
      payload = {
        cluster_name: cluster_name,
        password: cluster_password,
        node_hostname: node.hostname,
        node_ipaddress: node.ipaddress
      }.to_json
      res = @client.request(
        'POST',
        '/api/v1/node/register',
        craft_request_body(payload: payload)
      )
      return res
    end

    def get_scheduled_containers(cluster_name:, authentication_token:)
      payload = {
        cluster_name: cluster_name
      }.to_json
      res = @client.request(
        'GET',
        '/api/v1/node/containers/scheduled',
        craft_request_body(payload: payload, authentication_token: authentication_token)
      )
      return res
    end

    private

    def craft_request_body(payload:, authentication_token: nil)
      req = {
        'Body' => payload,
        'Content-Type' => 'application/json; charset=utf-8',
        'Content-Length' => payload.length 
      }
      req['X-Auth-Token'] = authentication_token unless authentication_token.nil?
      req
    end
  end
end

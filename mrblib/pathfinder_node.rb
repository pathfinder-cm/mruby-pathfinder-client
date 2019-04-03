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
        craft_request_body(payload)
      )
      return res
    end

    private

    def craft_request_body(payload)
      {
        'Body' => payload,
        'Content-Type' => 'application/json; charset=utf-8',
        'Content-Length' => payload.length 
      }
    end
  end
end

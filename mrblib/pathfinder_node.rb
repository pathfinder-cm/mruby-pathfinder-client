require(File.expand_path('node', File.dirname(__FILE__)))
require(File.expand_path('container', File.dirname(__FILE__)))

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

    def update_ipaddress(cluster_name:, authentication_token:, container:)
      payload = {
        cluster_name: cluster_name,
        hostname: container.hostname,
        ipaddress: container.ipaddress
      }.to_json
      res = @client.request(
        'POST',
        '/api/v1/node/containers/ipaddress',
        craft_request_body(payload: payload, authentication_token: authentication_token)
      )
      return res
    end

    def mark_container_as_provisioned(cluster_name:, authentication_token:, container:)
      payload = {
        cluster_name: cluster_name,
        hostname: container.hostname
      }.to_json
      res = @client.request(
        'POST',
        '/api/v1/node/containers/mark_provisioned',
        craft_request_body(payload: payload, authentication_token: authentication_token)
      )
      return res
    end

    def mark_container_as_provision_error(cluster_name:, authentication_token:, container:)
      payload = {
        cluster_name: cluster_name,
        hostname: container.hostname
      }.to_json
      res = @client.request(
        'POST',
        '/api/v1/node/containers/mark_provision_error',
        craft_request_body(payload: payload, authentication_token: authentication_token)
      )
      return res
    end

    def mark_container_as_deleted(cluster_name:, authentication_token:, container:)
      payload = {
        cluster_name: cluster_name,
        hostname: container.hostname
      }.to_json
      res = @client.request(
        'POST',
        '/api/v1/node/containers/mark_deleted',
        craft_request_body(payload: payload, authentication_token: authentication_token)
      )
      return res
    end

    def store_metrics(cluster_name:, authentication_token:, metrics:)
      payload = {
        cluster_name: cluster_name,
        memory: {
          free: metrics[:memory][:free],
          used: metrics[:memory][:used],
          total: metrics[:memory][:total]
        }
      }.to_json
      res = @client.request(
        'POST',
        '/api/v1/node/nodes/store_metrics',
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

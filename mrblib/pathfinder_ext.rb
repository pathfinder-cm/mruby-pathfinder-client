require(File.expand_path('node', File.dirname(__FILE__)))
require(File.expand_path('container', File.dirname(__FILE__)))

module Pathfinder
  class PathfinderExt
    def initialize(opts = {})
      opts[:scheme] ||= 'http'
      opts[:address] ||= 'localhost'
      @client = SimpleHttp.new(opts[:scheme], opts[:address], opts[:port])
    end

    def get_nodes(cluster_name:, authentication_token:)
      payload = {
        cluster_name: cluster_name
      }.to_json
      res = @client.request(
        'GET',
        '/api/v1/ext_app/nodes',
        craft_request_body(payload: payload, authentication_token: authentication_token)
      )
      return res
    end

    def get_node(cluster_name:, authentication_token:, node:)
      payload = {
        cluster_name: cluster_name
      }.to_json
      res = @client.request(
        'GET',
        "/api/v1/ext_app/nodes/#{node.hostname}",
        craft_request_body(payload: payload, authentication_token: authentication_token)
      )
      return res
    end

    def get_containers(cluster_name:, authentication_token:)
      payload = {
        cluster_name: cluster_name
      }.to_json
      res = @client.request(
        'GET',
        '/api/v1/ext_app/containers',
        craft_request_body(payload: payload, authentication_token: authentication_token)
      )
      return res
    end

    def get_container(cluster_name:, authentication_token:, container:)
      payload = {
        cluster_name: cluster_name
      }.to_json
      res = @client.request(
        'GET',
        "/api/v1/ext_app/containers/#{container.hostname}",
        craft_request_body(payload: payload, authentication_token: authentication_token)
      )
      return res
    end

    def create_container(cluster_name:, authentication_token:, container:)
      payload = {
        cluster_name: cluster_name,
        container: {
          hostname: container.hostname,
          image: container.image
        }
      }.to_json
      res = @client.request(
        'POST',
        '/api/v1/ext_app/containers',
        craft_request_body(payload: payload, authentication_token: authentication_token)
      )
      return res
    end

    def delete_container(cluster_name:, authentication_token:, container:)
      payload = {
        cluster_name: cluster_name
      }.to_json
      res = @client.request(
        'POST',
        "/api/v1/ext_app/containers/#{container.hostname}/schedule_deletion",
        craft_request_body(payload: payload, authentication_token: authentication_token)
      )
      return res
    end

    def reschedule_container(cluster_name:, authentication_token:, container:)
      payload = {
        cluster_name: cluster_name
      }.to_json
      res = @client.request(
        'POST',
        "/api/v1/ext_app/containers/#{container.hostname}/reschedule",
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

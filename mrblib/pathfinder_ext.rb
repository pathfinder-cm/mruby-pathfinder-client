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

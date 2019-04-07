require(File.expand_path('node', File.dirname(__FILE__)))
require(File.expand_path('container', File.dirname(__FILE__)))

module Pathfinder
  class PathfinderExt
    def initialize(cluster_name:, authentication_token:, scheme: 'http', address: 'localhost', port: 80)
      @cluster_name = cluster_name
      @authentication_token = authentication_token
      @client = SimpleHttp.new(scheme, address, port)
    end

    def get_nodes
      payload = {
        cluster_name: @cluster_name
      }.to_json
      res = @client.request(
        'GET',
        '/api/v1/ext_app/nodes',
        craft_request_body(payload: payload, authentication_token: @authentication_token)
      )
      if res.code == 200
        items = JSON.parse(res.body)['data']['items']
        nodes = items.map{ |m| Node.new(
          hostname: m['hostname'],
          ipaddress: m['ipaddress']
        )}
        return true, nodes
      else
        return false, nil
      end
    end

    def get_node(node:)
      payload = {
        cluster_name: @cluster_name
      }.to_json
      res = @client.request(
        'GET',
        "/api/v1/ext_app/nodes/#{node.hostname}",
        craft_request_body(payload: payload, authentication_token: @authentication_token)
      )
      if res.code == 200
        item = JSON.parse(res.body)['data']
        node = Node.new(
          hostname: item['hostname'],
          ipaddress: item['ipaddress']
        )
        return true, node
      else
        return false, nil
      end
    end

    def get_containers
      payload = {
        cluster_name: @cluster_name
      }.to_json
      res = @client.request(
        'GET',
        '/api/v1/ext_app/containers',
        craft_request_body(payload: payload, authentication_token: @authentication_token)
      )
      if res.code == 200
        items = JSON.parse(res.body)['data']['items']
        containers = items.map{ |m| Container.new(
          hostname: m['hostname'],
          ipaddress: m['ipaddress'],
          image: m['image'],
          status: m['status']
        )}
        return true, containers
      else
        return false, nil
      end
    end

    def get_container(container:)
      payload = {
        cluster_name: @cluster_name
      }.to_json
      res = @client.request(
        'GET',
        "/api/v1/ext_app/containers/#{container.hostname}",
        craft_request_body(payload: payload, authentication_token: @authentication_token)
      )
      if res.code == 200
        item = JSON.parse(res.body)['data']
        container = Container.new(
          hostname: item['hostname'],
          ipaddress: item['ipaddress'],
          image: item['image'],
          status: item['status']
        )
        return true, container
      else
        return false, nil
      end
    end

    def create_container(container:)
      payload = {
        cluster_name: @cluster_name,
        container: {
          hostname: container.hostname,
          image: container.image
        }
      }.to_json
      res = @client.request(
        'POST',
        '/api/v1/ext_app/containers',
        craft_request_body(payload: payload, authentication_token: @authentication_token)
      )
      if res.code == 200
        item = JSON.parse(res.body)['data']
        container = Container.new(
          hostname: item['hostname'],
          ipaddress: item['ipaddress'],
          image: item['image'],
          status: item['status']
        )
        return true, container
      else
        return false, nil
      end
    end

    def delete_container(container:)
      payload = {
        cluster_name: @cluster_name
      }.to_json
      res = @client.request(
        'POST',
        "/api/v1/ext_app/containers/#{container.hostname}/schedule_deletion",
        craft_request_body(payload: payload, authentication_token: @authentication_token)
      )
      if res.code == 200
        item = JSON.parse(res.body)['data']
        container = Container.new(
          hostname: item['hostname'],
          ipaddress: item['ipaddress'],
          image: item['image'],
          status: item['status']
        )
        return true, container
      else
        return false, nil
      end
    end

    def reschedule_container(container:)
      payload = {
        cluster_name: @cluster_name
      }.to_json
      res = @client.request(
        'POST',
        "/api/v1/ext_app/containers/#{container.hostname}/reschedule",
        craft_request_body(payload: payload, authentication_token: @authentication_token)
      )
      if res.code == 200
        item = JSON.parse(res.body)['data']
        container = Container.new(
          hostname: item['hostname'],
          ipaddress: item['ipaddress'],
          image: item['image'],
          status: item['status']
        )
        return true, container
      else
        return false, nil
      end
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

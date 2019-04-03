require(File.expand_path('../mrblib/pathfinder_node', File.dirname(__FILE__)))

module Pathfinder
  class PathfinderNodeTest < MTest::Unit::TestCase
    def shared_vars
      {
        cluster_name: 'default',
        cluster_password: 'pathfinder',
        node: Node.new(hostname: 'test-01', ipaddress: '127.0.0.1')
      }
    end

    def register
      pathfinder_node = PathfinderNode.new(port: 3000)
      response = pathfinder_node.register(
        cluster_name: shared_vars[:cluster_name],
        cluster_password: shared_vars[:cluster_password],
        node: shared_vars[:node]
      )
      JSON.parse(response.body)['data']['authentication_token']
    end

    def test_register_success
      pathfinder_node = PathfinderNode.new(port: 3000)
      response = pathfinder_node.register(
        cluster_name: shared_vars[:cluster_name],
        cluster_password: shared_vars[:cluster_password],
        node: shared_vars[:node]
      )
      assert_equal(200, response.code)
    end

    def test_get_scheduled_containers_success
      pathfinder_node = PathfinderNode.new(port: 3000)
      token = register
      response = pathfinder_node.get_scheduled_containers(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: token
      )
      assert_equal(200, response.code)
    end
  end
end

MTest::Unit.new.run

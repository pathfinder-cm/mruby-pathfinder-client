require(File.expand_path('../mrblib/pathfinder_ext', File.dirname(__FILE__)))

module Pathfinder
  class PathfinderExtTest < MTest::Unit::TestCase
    def shared_vars
      {
        cluster_name: 'default',
        authentication_token: 'pathfinder',
        node: Node.new(hostname: 'test-01', ipaddress: '127.0.0.1'),
      }
    end

    def test_get_nodes_success
      pathfinder_ext = PathfinderExt.new(port: 3000)
      response = pathfinder_ext.get_nodes(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: shared_vars[:authentication_token]
      )
      assert_equal(200, response.code)
    end

    def test_get_node_success
      pathfinder_ext = PathfinderExt.new(port: 3000)
      response = pathfinder_ext.get_node(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: shared_vars[:authentication_token],
        node: shared_vars[:node]
      )
      assert_equal(200, response.code)
    end
  end
end

MTest::Unit.new.run

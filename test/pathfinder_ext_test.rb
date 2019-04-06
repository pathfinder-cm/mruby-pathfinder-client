require(File.expand_path('../mrblib/pathfinder_ext', File.dirname(__FILE__)))

module Pathfinder
  class PathfinderExtTest < MTest::Unit::TestCase
    def shared_vars
      {
        cluster_name: 'default',
        authentication_token: 'pathfinder',
        node: Node.new(hostname: 'test-01', ipaddress: '127.0.0.1'),
        container: Container.new(hostname: 'test-01', ipaddress: '127.0.0.1', image: '18.04'),
      }
    end

    def test_get_nodes_success
      pathfinder_ext = PathfinderExt.new(port: 3000)
      ok, _ = pathfinder_ext.get_nodes(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: shared_vars[:authentication_token]
      )
      assert_equal(ok, true)
    end

    def test_get_node_success
      pathfinder_ext = PathfinderExt.new(port: 3000)
      ok, _ = pathfinder_ext.get_node(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: shared_vars[:authentication_token],
        node: shared_vars[:node]
      )
      assert_equal(ok, true)
    end

    def test_get_containers_success
      pathfinder_ext = PathfinderExt.new(port: 3000)
      ok, _ = pathfinder_ext.get_containers(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: shared_vars[:authentication_token]
      )
      assert_equal(ok, true)
    end

    def test_get_container_success
      pathfinder_ext = PathfinderExt.new(port: 3000)
      container = Container.new(hostname: Uuid.uuid, ipaddress: '127.0.0.1', image: '18.04')
      pathfinder_ext.create_container(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: shared_vars[:authentication_token],
        container: container
      )
      ok, _ = pathfinder_ext.get_container(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: shared_vars[:authentication_token],
        container: container
      )
      assert_equal(true, ok)
      pathfinder_ext.delete_container(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: shared_vars[:authentication_token],
        container: container
      )
    end

    def test_create_container_success
      pathfinder_ext = PathfinderExt.new(port: 3000)
      container = Container.new(hostname: Uuid.uuid, ipaddress: '127.0.0.1', image: '18.04')
      ok, _ = pathfinder_ext.create_container(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: shared_vars[:authentication_token],
        container: container
      )
      assert_equal(true, ok)
      pathfinder_ext.delete_container(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: shared_vars[:authentication_token],
        container: container
      )
    end

    def test_delete_container_success
      pathfinder_ext = PathfinderExt.new(port: 3000)
      container = Container.new(hostname: Uuid.uuid, ipaddress: '127.0.0.1', image: '18.04')
      pathfinder_ext.create_container(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: shared_vars[:authentication_token],
        container: container
      )
      ok, _ = pathfinder_ext.delete_container(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: shared_vars[:authentication_token],
        container: container
      )
      assert_equal(true, ok)
    end

    def test_reschedule_container_success
      pathfinder_ext = PathfinderExt.new(port: 3000)
      container = Container.new(hostname: Uuid.uuid, ipaddress: '127.0.0.1', image: '18.04')
      pathfinder_ext.create_container(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: shared_vars[:authentication_token],
        container: container
      )
      ok, _ = pathfinder_ext.reschedule_container(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: shared_vars[:authentication_token],
        container: container
      )
      assert_equal(true, ok)
      2.times { 
        pathfinder_ext.delete_container(
          cluster_name: shared_vars[:cluster_name],
          authentication_token: shared_vars[:authentication_token],
          container: container
        ) 
      }
    end
  end
end

MTest::Unit.new.run

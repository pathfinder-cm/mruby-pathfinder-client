require(File.expand_path('../mrblib/pathfinder_ext', File.dirname(__FILE__)))

module Pathfinder
  class PathfinderExtTest < MTest::Unit::TestCase
    def pathfinder_ext
      @pathfinder_ext ||= PathfinderExt.new(
        cluster_name: 'default', 
        authentication_token: 'pathfinder',
        port: 3000
      )
    end

    def shared_vars
      {
        node: Node.new(hostname: 'test-01', ipaddress: '127.0.0.1'),
        container: Container.new(hostname: Uuid.uuid, ipaddress: '127.0.0.1', image: '18.04'),
      }
    end

    def test_get_nodes_success
      ok, _ = pathfinder_ext.get_nodes
      assert_equal(ok, true)
    end

    def test_get_node_success
      ok, _ = pathfinder_ext.get_node(node: shared_vars[:node])
      assert_equal(ok, true)
    end

    def test_get_containers_success
      ok, _ = pathfinder_ext.get_containers
      assert_equal(ok, true)
    end

    def test_get_container_success
      container = shared_vars[:container]
      pathfinder_ext.create_container(container: container)
      ok, _ = pathfinder_ext.get_container(container: container)
      assert_equal(true, ok)
      pathfinder_ext.delete_container(container: container)
    end

    def test_create_container_success
      container = shared_vars[:container]
      ok, _ = pathfinder_ext.create_container(container: container)
      assert_equal(true, ok)
      pathfinder_ext.delete_container(container: container)
    end

    def test_delete_container_success
      container = shared_vars[:container]
      pathfinder_ext.create_container(container: container)
      ok, _ = pathfinder_ext.delete_container(container: container)
      assert_equal(true, ok)
    end

    def test_reschedule_container_success
      container = shared_vars[:container]
      pathfinder_ext.create_container(container: container)
      ok, _ = pathfinder_ext.reschedule_container(container: container)
      assert_equal(true, ok)
      2.times { pathfinder_ext.delete_container(container: container) }
    end
  end
end

MTest::Unit.new.run

require(File.expand_path('../mrblib/pathfinder_node', File.dirname(__FILE__)))

module Pathfinder
  class PathfinderNodeTest < MTest::Unit::TestCase
    def pathfinder_node
      @pathfinder_node ||= PathfinderNode.new(
        cluster_name: 'default', 
        authentication_token: 'pathfinder',
        port: 3000
      )
    end

    def shared_vars
      {
        cluster_password: 'pathfinder',
        node: Node.new(hostname: 'test-01', ipaddress: '127.0.0.1'),
        container: Container.new(hostname: 'test-01', ipaddress: '127.0.0.1'),
        metrics: {
          memory: {
            free: 80,
            used: 20,
            total: 100
          }
        }
      }
    end

    def register
      ok, authentication_token = pathfinder_node.register(
        cluster_password: shared_vars[:cluster_password],
        node: shared_vars[:node]
      )
      authentication_token
    end

    def test_register_success
      ok, _ = pathfinder_node.register(
        cluster_password: shared_vars[:cluster_password],
        node: shared_vars[:node]
      )
      assert_equal(true, ok)
    end

    def test_get_scheduled_containers_success
      register
      ok, _ = pathfinder_node.get_scheduled_containers
      assert_equal(true, ok)
    end

    # NOTE: test node must already have assigned container and is not 'DELETED'
    def test_update_ipaddress_success
      register
      ok = pathfinder_node.update_ipaddress(
        container: shared_vars[:container]
      )
      assert_equal(true, ok)
    end

    # NOTE: test node must already have assigned container with status: 'SCHEDULED'
    def test_mark_container_as_provisioned_success
      register
      ok, _ = pathfinder_node.mark_container_as_provisioned(
        container: shared_vars[:container]
      )
      assert_equal(true, ok)
    end

    # NOTE: test node must already have assigned container with status: 'SCHEDULED'
    def test_mark_container_as_provision_error_success
      register
      ok, _ = pathfinder_node.mark_container_as_provision_error(
        container: shared_vars[:container]
      )
      assert_equal(true, ok)
    end

    # NOTE: test node must already have assigned container with status: 'SCHEDULE_DELETION'
    def test_mark_container_as_deleted_success
      register
      ok, _ = pathfinder_node.mark_container_as_deleted(
        container: shared_vars[:container]
      )
      assert_equal(true, ok)
    end

    def test_store_metrics_success
      register
      ok = pathfinder_node.store_metrics(
        metrics: shared_vars[:metrics]
      )
      assert_equal(true, ok)
    end
  end
end

MTest::Unit.new.run

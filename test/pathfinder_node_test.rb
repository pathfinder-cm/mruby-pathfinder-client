require(File.expand_path('../mrblib/pathfinder_node', File.dirname(__FILE__)))

module Pathfinder
  class PathfinderNodeTest < MTest::Unit::TestCase
    def shared_vars
      {
        cluster_name: 'default',
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

    # NOTE: test node must already have assigned container and is not 'DELETED'
    def test_update_ipaddress_success
      pathfinder_node = PathfinderNode.new(port: 3000)
      token = register
      response = pathfinder_node.update_ipaddress(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: token,
        container: shared_vars[:container]
      )
      assert_equal(200, response.code)
    end

    # NOTE: test node must already have assigned container with status: 'SCHEDULED'
    def test_mark_container_as_provisioned_success
      pathfinder_node = PathfinderNode.new(port: 3000)
      token = register
      response = pathfinder_node.mark_container_as_provisioned(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: token,
        container: shared_vars[:container]
      )
      assert_equal(200, response.code)
    end

    # NOTE: test node must already have assigned container with status: 'SCHEDULED'
    def test_mark_container_as_provision_error_success
      pathfinder_node = PathfinderNode.new(port: 3000)
      token = register
      response = pathfinder_node.mark_container_as_provision_error(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: token,
        container: shared_vars[:container]
      )
      assert_equal(200, response.code)
    end

    # NOTE: test node must already have assigned container with status: 'SCHEDULE_DELETION'
    def test_mark_container_as_deleted_success
      pathfinder_node = PathfinderNode.new(port: 3000)
      token = register
      response = pathfinder_node.mark_container_as_deleted(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: token,
        container: shared_vars[:container]
      )
      assert_equal(200, response.code)
    end

    def test_store_metrics_success
      pathfinder_node = PathfinderNode.new(port: 3000)
      token = register
      response = pathfinder_node.store_metrics(
        cluster_name: shared_vars[:cluster_name],
        authentication_token: token,
        metrics: shared_vars[:metrics]
      )
      assert_equal(200, response.code)
    end
  end
end

MTest::Unit.new.run

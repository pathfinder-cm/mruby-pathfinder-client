module Pathfinder
  class Node
    attr_reader :hostname, :ipaddress

    def initialize(hostname:, ipaddress:)
      @hostname = hostname
      @ipaddress = ipaddress
    end
  end
end

module Pathfinder
  class Container
    attr_reader :hostname, :ipaddress, :image, :status

    def initialize(hostname:, ipaddress:, image: '', status: '')
      @hostname = hostname
      @ipaddress = ipaddress
      @image = image
      @status = status
    end
  end
end

# = Archon.coalesce
module Archon
  def self.coalesce(*coalescees)
    return Nodes::Coalesce.new(*coalescees)
  end

  module Nodes
    # = Coalesce
    #
    # An Arel node that generates a 'COALESCE' statement
    class Coalesce < Arel::Nodes::NamedFunction
      def initialize(*coalescees)
        super 'COALESCE', coalescees
      end
    end
  end
end

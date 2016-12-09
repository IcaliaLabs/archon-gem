module Archon
  # = Nodes
  # A collection of ARel nodes that do powerful stuff
  module Nodes
    extend ActiveSupport::Autoload

    autoload :Coalesce
    autoload :PopulatedRecordset
  end
end

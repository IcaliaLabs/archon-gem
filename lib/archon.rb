require "archon/version"

# = Archon
#
# Archon is a collection of Arel nodes, shortcut methods and ActiveRecord model methods that make
# doing complicated stuff relatively simpler.
module Archon
  extend ActiveSupport::Autoload

  autoload :Nodes
  autoload :InsertIntoSelect

  def self.method_missing(called_method_name, *arguments, &block)
    # Call super to raise a method missing error if no class was loaded:
    called_method_name_as_constant = called_method_name.to_s.camelize
    super unless [
      "Archon::Nodes::#{called_method_name_as_constant}".safe_constantize,
      "Archon::#{called_method_name_as_constant}".safe_constantize
    ].compact!.any?

    # Try again, this time we expect the loaded module added the method to Archon:
    send called_method_name, *arguments, &block
  end
end

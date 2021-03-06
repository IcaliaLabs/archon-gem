# = Archon.populated_recordset
module Archon
  def self.populated_recordset(base, rows = [])
    return Nodes::PopulatedRecordset.new base, rows
  end

  module Nodes
    # = PopulatedRecordset
    #
    # This ARel node creates a populated recordset from a JSON generated by the given ruby array of
    # hashes.
    class PopulatedRecordset < Arel::Nodes::NamedFunction
      def initialize(base, rows = [])
        raise ArgumentError, "rows is not an array" unless rows.is_a? Array
        super 'json_populate_recordset', [
          Arel::Nodes::SqlLiteral.new(base),
          Arel::Nodes::Quoted.new(ActiveSupport::JSON.encode(rows))
        ]
      end

      def aliased_as(recordset_alias)
        Arel::Nodes::TableAlias.new(self, recordset_alias)
      end

      def selectable
        Arel::SelectManager.new self
      end
    end
  end
end

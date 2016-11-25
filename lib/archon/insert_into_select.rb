# = Archon.insert_into_select
module Archon
  def self.insert_into_select(insertion_table, selection, options = {})
    return InsertIntoSelect.new insertion_table, selection, options
  end

  # = InsertIntoSelect
  #
  # Extends an ARel InsertManager that will generate an `INSERT INTO (...) SELECT` query, which will
  # insert data into the given table from the given selection - either an ARel SelectManager-ish, or
  # an ActiveRecord::Relation.
  #
  # It will try to determine the columns that will be inserted from the projections specified in the
  # given selection.
  class InsertIntoSelect < Arel::InsertManager
    attr_reader :projections
    def initialize(tableish, selectish, options = {})
      super()
      self.into tableish.respond_to?(:arel_table) ? tableish.arel_table : tableish
      self.select selectish.respond_to?(:arel) ? selectish.arel : selectish

      # Fetch the insert columns from the options - default to the select column names interpolated
      # into the inserted table:
      self.columns.concat options.fetch(
        :columns,
        ast.select.projections.map do |projection|
          column_name = if projection.is_a? Arel::Attributes::Attribute
                          projection.name
                        elsif projection.is_a? Arel::Nodes::As
                          projection.right.delete('"', '').to_sym
                        elsif projection.is_a? Arel::Nodes::NamedFunction
                          projection.alias.delete('"', '').to_sym
                        else
                          raise "Don't know how to..."
                        end
          ast.relation[column_name]
        end
      )
    end
  end
end

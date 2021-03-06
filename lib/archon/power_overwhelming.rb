module Archon
  # = PowerOverwhelming
  #
  # Packs several powerful convenient methods for ActiveRecord models. You can add them like this:
  #
  # == ActiveRecord >= 5.x
  #  ```
  #  # app/models/application_record.rb
  #  class ApplicationRecord < ActiveRecord::Base
  #    self.abstract_class = true
  #    include Archon::PowerOverwhelming
  #  end
  # ```
  #
  # == ActiveRecord >= 4.2.x, < 5.x
  #  ```
  #  # initializers/archon.rb
  #  ActiveRecord::Base.send :include, Archon::PowerOverwhelming
  #  ```
  module PowerOverwhelming
    extend ActiveSupport::Concern

    # = Archon::PowerOverwhelming::ClassMethods
    # Some methods applied to model classes and ActiveRecord::Relation objects
    module ClassMethods
      def create_from(selectish)
        transaction do
          timestamp = ActiveRecord::Base.connection.quoted_date(Time.now)
          timestamp = Arel::Nodes::SqlLiteral.new("'#{timestamp}'")

          insert_result = connection.execute Archon.insert_into_select(
            arel_table, selectish.arel
          ).to_sql

          Rails.logger.debug "Inserted #{insert_result.cmd_tuples} records " \
                             "to table '#{arel_table.name}'."
          insert_result
        end
      end
    end
  end
end

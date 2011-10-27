# lib/mongo_mapper_ext/mongo_mapper_soft_delete.rb
#
# Usage:
# class Site
#   include MongoMapper::Document
#
#   plugin MongoMapper::Plugins::DefaultScope
#   plugin MongoMapper::Plugins::SoftDelete
#
#   default_scope :deleted_at => nil
#   ...
# end
#
# site.destroy
# user.sites.destroy
#
# Site.hard_delete(*ids)
# Site.hard_delete_with_exclusive_scope(*ids)
module MongoMapper
  module Plugins
    module SoftDelete
      extend ActiveSupport::Concern

      def self.append_features(base)
        class << base
          # If you want to delete a record which has been soft deleted, use
          #   Model.hard_delete_with_exclusive_scope(*ids)
          # If you want to delete a record which has NOT been soft deleted, use
          #   Model.hard_delete(*ids)
          alias_method :hard_delete, :delete
        end
        super
      end

      included do
        key :deleted_at, Time, :default => nil
      end

      module ClassMethods
        def delete(*ids)
          query(:_id => ids.flatten).all.each(&:soft_delete)
        end

        def delete_all(options={})
          query(options).all.each(&:soft_delete)
        end
      end

      module InstanceMethods
        private

        def soft_delete
          self.deleted_at = Time.now.utc
          save(:validate => false)
        end
      end

    end
  end
end

module MongoMapper
  module Plugins
    module Associations
      class ManyDocumentsProxy < Collection

        def delete_all(options={})
          klass.delete_all(options)
          reset
        end

      end
    end

  end
end

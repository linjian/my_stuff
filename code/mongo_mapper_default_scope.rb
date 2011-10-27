# lib/mongo_mapper_ext/mongo_mapper_default_scope.rb
#
# Copy from rails-ext-0.3.29/lib/mongo_mapper_ext/plugins/default_scope.rb
# See http://rubygems.org/gems/rails-ext
#
# The implementation has been modified based on origin version:
# * Add query method to replace methods find_one, find_many, count.
# * Remove dependence on ruby-ext.
# * Support dynamic methods xxx_with_exclusive_scope.
#
# Usage:
# class Site
#   include MongoMapper::Document
#
#   plugin MongoMapper::Plugins::DefaultScope
#   default_scope :deleted_at => nil
#   ...
# end
#
# Site.find(id)
# Site.find_with_exclusive_scope(id)
module MongoMapper
  module Plugins
    module DefaultScope
      extend ActiveSupport::Concern

      module ClassMethods
        def query(options={})
          super default_scope_options.merge(options)
        end

        def with_exclusive_scope(options = {}, &block)
          before = Thread.current['mm_with_exclusive_scope']
          begin
            Thread.current['mm_with_exclusive_scope'] = options
            block.call if block
          ensure
            Thread.current['mm_with_exclusive_scope'] = before
          end
        end

        def with_scope(options = {}, &block)
          before = Thread.current['mm_with_scope']
          begin
            options = before.merge options if before
            Thread.current['mm_with_scope'] = options
            block.call if block
          ensure
            Thread.current['mm_with_scope'] = before
          end
        end

        protected

        def default_scope(options = nil, &block)
          self.write_inheritable_attribute(:default_scope, (options || block))
        end

        private

        def default_scope_options
          exclusive_options = Thread.current['mm_with_exclusive_scope']
          return exclusive_options if exclusive_options

          default_scope = self.read_inheritable_attribute(:default_scope)

          options = if default_scope
            if default_scope.respond_to? :call
              default_scope.call self
            else
              default_scope
            end
          else
            {}
          end

          if scope_options = Thread.current['mm_with_scope']
            options = options.merge scope_options
          end

          options
        end

        def method_missing(method, *args)
          if method.to_s =~ /^([_a-zA-Z]+)_with_exclusive_scope$/
            with_exclusive_scope do
              self.send($1, *args)
            end
          else
            super
          end
        end
      end

    end
  end
end

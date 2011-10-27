# config/initializers/without_callback.rb
#
# Usage:
# Site.without_callback(:destroy, :after, :decrease_sites_count) do
#   ...
# end
module ActiveSupport::Callbacks::ClassMethods
  def without_callback(*args, &block)
    skip_callback(*args)
    yield
    set_callback(*args)
  end
end

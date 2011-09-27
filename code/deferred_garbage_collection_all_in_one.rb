# http://ariejan.net/2011/09/24/rspec-speed-up-by-tweaking-ruby-garbage-collection

# Usage:
# DEFER_GC=10 rspec spec/
# DEFER_GC=10 cucumber features/

# put it to spec/support/
#        or feature/support/hooks.rb
class DeferredGarbageCollection
  DEFERRED_GC_THRESHOLD = (ENV['DEFER_GC'] || -1).to_f

  @last_gc_run = Time.now

  def self.start
    GC.disable if DEFERRED_GC_THRESHOLD > 0
  end

  def self.reconsider
    if DEFERRED_GC_THRESHOLD > 0 && Time.now - @last_gc_run >= DEFERRED_GC_THRESHOLD
      GC.enable
      GC.start
      GC.disable
      @last_gc_run = Time.now
    end
  end
end

if defined?(Cucumber)
  # put it to feature/support/hooks.rb
  Before do
    DeferredGarbageCollection.start
  end

  After do
    DeferredGarbageCollection.reconsider
  end
elsif defined?(RSpec)
  # put it to spec/spec_helper.rb
  RSpec.configure do |config|
    config.before(:all) do
      DeferredGarbageCollection.start
    end

    config.after(:all) do
      DeferredGarbageCollection.reconsider
    end
  end
end

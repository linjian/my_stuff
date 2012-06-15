# Copy from railties-3.0.10/lib/rails/tasks/routes.rake
#
# Put it to .irbrc
# Call it in console as:
#   __routes                    # => all routes
#   __routes('pause')           # => all routes matched "pause"
#   __routes('pause|resume')    # => all routes matched "pause" or "resume"
#   __routes(nil, 'sites')      # => all routes of sites controller
#   __routes('user', nil, true) # => reload routes, and show all routes matched "user"

def __routes(filter = nil, controller = nil, reload = false)
  Rails.application.reload_routes! if reload
  all_routes = Rails.application.routes.routes

  if controller
    all_routes = all_routes.select{ |route| route.defaults[:controller] == controller.to_s }
  end
  all_routes = all_routes.select{ |route| route.path =~ %r{#{filter}} } if filter

  routes = all_routes.collect do |route|

    reqs = route.requirements.dup
    reqs[:to] = route.app unless route.app.class.name.to_s =~ /^ActionDispatch::Routing/
    reqs = reqs.empty? ? "" : reqs.inspect

    {:name => route.name.to_s, :verb => route.verb.to_s, :path => route.path, :reqs => reqs}
  end

  routes.reject! { |r| r[:path] =~ %r{/rails/info/properties} } # Skip the route if it's internal info route

  name_width = routes.map{ |r| r[:name].length }.max
  verb_width = routes.map{ |r| r[:verb].length }.max
  path_width = routes.map{ |r| r[:path].length }.max

  routes.each do |r|
    puts "#{r[:name].rjust(name_width)} #{r[:verb].ljust(verb_width)} #{r[:path].ljust(path_width)} #{r[:reqs]}"
  end; nil
end

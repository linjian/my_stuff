if defined? ::Rails
  # Set variables ########################################################
  def __set_vars_for_main(name, value)
    return if value.nil?
    TOPLEVEL_BINDING.eval('self').instance_eval do
      self.class_eval { attr_accessor name }
      self.send("#{name}=", value)
    end
  end

  def __without_name_error
    yield
  rescue NameError => e
    nil
  end

  # __set_vars_for_main(:user,    __without_name_error { User.first(:email => 'jianlin@yottaa.com') })
  # __set_vars_for_main(:account, __without_name_error { user.account })
  # Set variables ########################################################


  # get rails routes ########################################################
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
  # get rails routes ########################################################

end

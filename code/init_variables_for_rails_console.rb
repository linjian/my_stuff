# Two scripts to initialize variables for rails console.
# I prefer the second one.


# Solution 1:
#   Puts it in ~/.irbrc
#   then type '__init_vars_by_binding(binding).call' after rails console loaded.
if defined? ::Rails
  def __init_vars_by_binding(binding)
    Proc.new do
      __quiet_name_error { binding.eval("user    = User.first(:email => 'linjian815@gmail.com')") }
      __quiet_name_error { binding.eval("account = user.account") }
    end
  end

  def __quiet_name_error
    yield
  rescue NameError => e
    # Be quiet
  end
end


# Solution 2:
#   Just puts it in ~/.irbrc, that's all, no more typing needed.
if defined? ::Rails
  def __set_vars_for_main(name, value)
    TOPLEVEL_BINDING.eval('self').instance_eval do
      return if value.nil?
      self.class_eval { attr_accessor name }
      self.send("#{name}=", value)
    end
  end

  def __without_name_error
    yield
  rescue NameError => e
    nil
  end

  __set_vars_for_main(:user,    __without_name_error { User.first(:email => 'linjian815@gmail.com') })
  __set_vars_for_main(:account, __without_name_error { user.account })
end

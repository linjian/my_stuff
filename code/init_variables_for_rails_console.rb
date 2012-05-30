# I wrote two scripts to initialize variables for rails console.
# I prefer the second one.


# Solution 1:
#   Puts it in ~/.irbrc
#   then type '__init_vars_for_main(binding).call' after rails console loaded.
if defined? ::Rails
  def __init_vars_for_main(binding)
    Proc.new do
      binding.eval("user    = User.first(:email => 'linjian815@gmail.com')")
      binding.eval("account = user.account")
    end
  end
end


# Solution 2:
#   Just puts it in ~/.irbrc, that's all, no more typing needed.
if defined? ::Rails
  def __set_vars_for_main(name, value)
    TOPLEVEL_BINDING.eval('self').instance_eval do
      self.class.send(:attr_accessor, name)
      self.send("#{name}=", value)
    end
  end

  __set_vars_for_main(:user,    User.first(:email => 'linjian815@gmail.com'))
  __set_vars_for_main(:account, user.account)
end

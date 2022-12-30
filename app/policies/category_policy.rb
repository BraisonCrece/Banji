class CategoryPolicy < BasePolicy
  # To clean up this class, and because all methods return the same
  # I thought it might be a good idea to override the `method_missing` method
  # because it is the method of the super that responds when the call is sent with a method that is not defined... 
  # And, if I don't define any method, it will always respond
  def method_missing(m, *args, &block)
    Current.user.admin?
  end

end
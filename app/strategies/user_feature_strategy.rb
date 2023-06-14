class UserFeatureStrategy < Flipflop::Strategies::AbstractStrategy
  class << self
    def default_description
      "Allows configuration of features per user."
    end
  end

  def switchable?
    true
  end

  def enabled?(feature)
    FeatureUser.exists?(user_id: request.session[:user_id])
  end
end

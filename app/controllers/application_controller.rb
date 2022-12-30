class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include Error
  include Pagy::Backend

end

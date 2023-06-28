# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit::Authorization
  include Pagy::Backend

  include ExceptionFilter
  include JSONAPIRender
end

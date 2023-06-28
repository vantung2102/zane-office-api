# frozen_string_literal: true

module ExceptionFilter
  extend ActiveSupport::Concern

  included do
    rescue_from Pundit::NotAuthorizedError,
                with: ->(e) { log_error(e) && render_api_error(APIError::NotAuthorizedError.new) }

    rescue_from ActiveRecord::RecordNotFound,
                with: ->(e) { log_error(e) && render_api_error(APIError::NotFoundError.new) }

    rescue_from ActiveRecord::RecordInvalid,
                ActiveRecord::RecordNotDestroyed,
                with: ->(e) { log_error(e) && render_api_error(APIError::RecordInvalidError.new(e.record.errors)) }

    rescue_from ActionController::ParameterMissing,
                with: ->(e) { log_error(e) && render_api_error(APIError::ParamMissingError.new(e.param)) }

    rescue_from APIError::StandardError,
                with: ->(e) { log_error(e) && render_api_error(e) }
  end

  private

  def log_error(error)
    Rails.logger.error(error)
  end

  def render_api_error(error)
    render json: APIErrorSerializer.new(error), status: error.status
  end
end

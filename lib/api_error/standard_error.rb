# frozen_string_literal: true

module APIError
  class StandardError < ::StandardError
    attr_reader :message, :errors, :status, :code

    def initialize(message: nil, errors: [], status: nil, code: nil) # rubocop:disable Lint/MissingSuper
      @message = message
      @errors = errors
      @status = status
      @code = code
    end

    def to_hash
      {
        message:,
        errors:,
        status:,
        code:
      }
    end

    def serializable_hash
      to_hash.compact_blank
    end
  end
end

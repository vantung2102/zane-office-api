# frozen_string_literal: true

module APIError
  class RecordInvalidError < StandardError
    def initialize(errors = [])
      super(
        message: 'Unprocessable Entity',
        errors:,
        status: 422
      )
    end

    def serializable_hash
      {
        message:,
        status:,
        errors: serializable_errors(errors)
      }
    end

    private

    def serializable_errors(errors)
      errors.each_with_object([]) do |error, memo|
        memo << {
          field: error.attribute,
          message: error.full_message
        }
      end
    end
  end
end

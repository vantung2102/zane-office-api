# frozen_string_literal: true

class JsonToken
  def self.jwt_encode(data, exp = 1.months.from_now)
    payload = { data:, exp: exp.to_i }
    JWT.encode(payload, secret_key)
  end

  def self.jwt_decode(token)
    decode = JWT.decode(token, secret_key).first
    ActiveSupport::HashWithIndifferentAccess.new(decode)
  end

  def self.secret_key
    ENV['JWT_SECRET'] || Rails.application.secrets.secret_key_base.to_s
  end

  private_class_method :secret_key
end

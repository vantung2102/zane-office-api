module Auth
  class LoginService < ApplicationService
    
    def initialize(session)
      @email = session[:email]
      @password = session[:password]
    end
    
    def call
      user = Employee.find_by(email: email)
      user&.authenticate(password) || raise(APIError::NotAuthenticatedError, 'Invalid email or password')
    end

    private
    
    attr_reader :email, :password
  end
end

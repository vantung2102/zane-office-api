module Auth
  class RegisterEmployeeService < ApplicationService
    attr_reader :params, :role

    def initialize(params)
      @params = params.except(:role)
      @role = params[:role]
    end

    def call
      Employee.create!(params)
    end
  end
end

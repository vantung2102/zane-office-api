module API
  module V1
    module Auth
      class RegistrationsController < BaseController
        skip_before_action :authenticate_user!
  
        def create
          employee = ::Auth::RegisterEmployeeService.call(employee_params)
          employee.generate_email_verification_token!
          RegistrationMailer.with(employee: employee).verification_email.deliver_now
          render_resource(employee, view: :auth, status: :created)
        end
  
        def verify
          employee = Employee.find_by!(email_verification_token: verification_token)
          if employee.email_token_expired?
            render_api_error(APIError::NotAuthenticatedError.new('Code is not valid or expired'))
          else
            employee.verify_email!
            render_resource(employee)
          end
        end
  
        private
  
        def employee_params
          params.require(:employee).permit(
            :first_name,
            :last_name,
            :join_date,
            :dob,
            :nationality_code,
            :address,
            :email,
            :password,
            :phone_code,
            :phone_number,
            :name,
            :role,
            :gender,
            :phone_code,
            :phone_number,
            :user_name,
            :password
          )
        end
  
        def verification_token
          params.require(:verification_token)
        end
      end
    end
  end
end

module API
  module V1
    class SessionsController < BaseController
      skip_before_action :authenticate_user!, only: :log_in

      def log_in
        employee = Auth::LoginService.call(session_params)
        render_resource(employee, view: :auth)
      end

      private

      def session_params
        params.require(:employee).permit(:email, :password)
      end
    end
  end
end

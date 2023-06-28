class RegistrationMailer < ApplicationMailer
  default from: 'zane.office@gmail.com'

  def verification_email
    @employee = params[:employee]
    mail(to: @employee.email, subject: 'Registration Confirmation')
  end

  def forgot_email
    @employee = params[:employee]
    mail(to: @employee.email, subject: 'Reset your password')
  end
end

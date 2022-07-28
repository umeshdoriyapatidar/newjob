# frozen_string_literal: true

class ApplyConfirmationMailer < ApplicationMailer
  #  default from: 'jober@email.com'

  def accept_confirmation_email
    @applicant = params[:applicant]
    @job = params[:job]

    mail(to: @applicant.email, subject: 'Your application has been accepted succesfully')
  end

  def apply_confirmation_email
    @applicant = params[:applicant]
    @job = params[:job]
    @employee = params[:employee]
    mail(to: @employee.email, subject: 'Application recieve')
  end

  def send_otp
    @otp = params[:ranotp]
    @applicant = params[:applicant]
    mail(to: @applicant.email, subject: 'One Time Password')
  end
end

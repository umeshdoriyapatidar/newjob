# frozen_string_literal: true

class JobApplicationsController < ApplicationController
  include JobApplicationsHelper
  authorize_resource
  def index
    @job_applications = current_user.applied_jobs.page(params[:page])  if current_user.has_role? :applicant
  end

  def user_application
    job = Job.find(params[:id])
    if valid_employer(current_user, job)
      @job_applications = job.job_applications.page(params[:page])
    else
      flash[:alert] = "Sorry you can't watch other's applications"
      redirect_to root_url
    end
  end

  def apply
    if current_user.has_role? :applicant

      @job = Job.find(params[:job_id])
      current_user.aply(@job)
      emp_id = @job.user_id
      @employee = User.find(emp_id)
      @applicant = current_user
      ApplyConfirmationMailer.with(applicant: @applicant, job: @job,
                                   employee: @employee).apply_confirmation_email.deliver
    else

      flash[:alert] = 'sorry you can not apply for this job'
      redirect_to root_url

    end
  end

  def accept
    @job = Job.find(params[:jobs_id])
    if valid_employer(current_user, @job)
      job_application = JobApplication.find_by(job_id: params[:jobs_id], user_id: params[:user_id])
      job_application.accepted!
      @applicant = User.find(params[:user_id])
      ApplyConfirmationMailer.with(applicant: @applicant, job: @job).accept_confirmation_email.deliver
      redirect_to jobs_path
    else
      flash[:alert] = 'You are not authorized to access this page'
      redirect_to root_url
    end
  end

  def rejected
    job_application = JobApplication.find_by(job_id: params[:jobs_id], user_id: params[:user_id])
    job_application.rejected!
    job_application.delete
    redirect_to root_url
  end

  def destroy 
    @job=Job.find(params[:id])
    current_user.applied_jobs.destroy(@job)
    flash[:alert] = 'apply removed succesfully'
    redirect_to root_url
  end

  def verify
    $job_id = params[:job_id]
    otp = rand(1000..9999)
    $global_otp = otp
    @applicant = current_user
    ApplyConfirmationMailer.with(applicant: @applicant, ranotp: otp).send_otp.deliver
    render 'job_applications/verify'
  end

  def verifyotp
    newotp = params[:apply_otp]
    current_user.update(apply_otp: params[:apply_otp])
    @job_id = params[:job_id]
    if $global_otp == current_user.apply_otp
      flash[:notice] = 'Otp verfied succefully'
      redirect_to job_applications_apply_path(job_id: $job_id) and return true
    else
      flash[:alert] = "Sorry it's Wrong Otp"
      redirect_to jobs_path
    end
  end
end
